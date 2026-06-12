using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DOAN_BTF.Models;
using Microsoft.AspNetCore.Authorization;

namespace DOAN_BTF.Controllers
{
    [Authorize(Roles = "Admin")]
    public class AnalyticsController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public AnalyticsController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index(int? roomId, int? shopId, DateTime? fromDate, DateTime? toDate)
        {
            fromDate ??= DateTime.Now.AddDays(-30);
            toDate ??= DateTime.Now;

            var orderQuery = _context.Orders
                .Include(o => o.OrderDetails)
                .Include(o => o.Room)
                .Include(o => o.Shop)
                .Where(o => o.CreateAt >= fromDate && o.CreateAt <= toDate)
                .AsNoTracking();

            if (roomId.HasValue)
                orderQuery = orderQuery.Where(o => o.RoomId == roomId);

            if (shopId.HasValue)
                orderQuery = orderQuery.Where(o => o.ShopId == shopId);

            var orders = await orderQuery.ToListAsync();

            ViewBag.TotalOrders = orders.Count;
            ViewBag.TotalProductsEmbroidered = orders.Sum(o => o.OrderDetails.Sum(d => d.Quantity ?? 0));
            ViewBag.TotalCurrentStock = await _context.Inventories.SumAsync(i => i.Quantity ?? 0);

            ViewBag.RoomAnalytics = orders
                .Where(o => o.Room != null)
                .GroupBy(o => o.Room!.RoomName)
                .Select(g => new { Name = g.Key, Count = g.Count() })
                .ToList();

            ViewBag.ShopAnalytics = orders
                .Where(o => o.Shop != null)
                .GroupBy(o => o.Shop!.ShopName)
                .Select(g => new { Name = g.Key, Count = g.Count() })
                .ToList();

            var topProducts = orders
                .SelectMany(o => o.OrderDetails)
                .GroupBy(d => d.ProductVariantId)
                .Select(g => new
                {
                    VariantId = g.Key,
                    TotalQty = g.Sum(d => d.Quantity ?? 0)
                })
                .OrderByDescending(x => x.TotalQty)
                .Take(5)
                .ToList();

            var topProductLabels = new List<string>();
            var topProductData = new List<int>();

            foreach (var item in topProducts)
            {
                var variant = await _context.ProductVariants
                    .Include(v => v.Product)
                    .FirstOrDefaultAsync(v => v.Id == item.VariantId);

                if (variant != null)
                {
                    topProductLabels.Add($"{variant.Product?.ProductName} - {variant.Color} [{variant.Size}]");
                    topProductData.Add(item.TotalQty);
                }
            }

            ViewBag.TopProductLabels = topProductLabels;
            ViewBag.TopProductData = topProductData;

            // ==========================
            // TÍNH TRUNG BÌNH TRƯỢT 7 NGÀY
            // ==========================
            var dailyData = orders
    .Where(o => o.CreateAt.HasValue)
    .GroupBy(o => o.CreateAt!.Value.Date)
    .Select(g => new
    {
        Date = g.Key,
        TotalQty = g.Sum(o => o.OrderDetails.Sum(d => d.Quantity ?? 0))
    })
    .OrderBy(x => x.Date)
    .ToList();

            var movingAverageLabels = new List<string>();
            var movingAverageData = new List<double>();

            int windowSize = 7;

            for (int i = 0; i < dailyData.Count; i++)
            {
                var window = dailyData
                    .Skip(Math.Max(0, i - windowSize + 1))
                    .Take(Math.Min(windowSize, i + 1))
                    .ToList();

                double avg = window.Average(x => x.TotalQty);

                movingAverageLabels.Add(dailyData[i].Date.ToString("dd/MM"));
                movingAverageData.Add(Math.Round(avg, 2));
            }

            ViewBag.MovingAverageLabels = movingAverageLabels;
            ViewBag.MovingAverageData = movingAverageData;

            var latestMovingAverage = movingAverageData.LastOrDefault();
            ViewBag.LatestMovingAverage = latestMovingAverage;

            // ==========================
            // DỰ BÁO DỰA TRÊN TRUNG BÌNH TRƯỢT
            // ==========================
            var primaryVariantId = topProducts.FirstOrDefault()?.VariantId;

            if (primaryVariantId.HasValue)
            {
                var currentStock = await _context.Inventories
                    .Where(i => i.ProductVariantId == primaryVariantId)
                    .Select(i => i.Quantity)
                    .FirstOrDefaultAsync() ?? 0;

                var alertVariant = await _context.ProductVariants
                    .Include(v => v.Product)
                    .FirstOrDefaultAsync(v => v.Id == primaryVariantId);

                var estimatedNeed30Days = (int)Math.Ceiling(latestMovingAverage * 30);

                if (currentStock <= estimatedNeed30Days)
                {
                    ViewBag.ForecastStatus = "Danger";
                    ViewBag.ForecastMessage =
                        $"[CẢNH BÁO NHẬP HÀNG] Mẫu phôi '{alertVariant?.Product?.ProductName} - {alertVariant?.Color}' đang có xu hướng tiêu thụ cao. Trung bình trượt 7 ngày hiện tại là {latestMovingAverage} chiếc/ngày. Dự kiến 30 ngày tới cần khoảng {estimatedNeed30Days} chiếc, trong khi tồn kho hiện tại còn {currentStock} chiếc. Hệ thống đề xuất nhập thêm phôi áo.";
                }
                else
                {
                    ViewBag.ForecastStatus = "Safe";
                    ViewBag.ForecastMessage =
                        $"Trung bình trượt 7 ngày hiện tại là {latestMovingAverage} chiếc/ngày. Lượng tồn kho hiện tại vẫn đủ đáp ứng nhu cầu sản xuất trong thời gian tới.";
                }
            }
            else
            {
                ViewBag.ForecastStatus = "Info";
                ViewBag.ForecastMessage =
                    "Chưa đủ dữ liệu đơn hàng trong khoảng thời gian này để tính trung bình trượt và đưa ra dự báo.";
            }

            // ==========================
            // FAKE DATA DEMO KHI CHƯA CÓ DỮ LIỆU THẬT
            // ==========================
            if (ViewBag.TotalOrders == 0)
            {
                ViewBag.TotalOrders = 108;
                ViewBag.TotalProductsEmbroidered = 589;
                ViewBag.TotalCurrentStock = 21322;

                ViewBag.RoomAnalytics = new List<object>
        {
            new { Name = "Phòng Kinh Doanh 1", Count = 42 },
            new { Name = "Phòng Kinh Doanh 2", Count = 31 },
            new { Name = "Phòng Kinh Doanh 3", Count = 22 },
            new { Name = "Phòng Kinh Doanh 4", Count = 13 }
        };

                ViewBag.ShopAnalytics = new List<object>
        {
            new { Name = "Lunet1", Count = 52 },
            new { Name = "Velora1", Count = 41 },
            new { Name = "Mivie2", Count = 37 },
            new { Name = "Nuvie1", Count = 29 }
        };

                ViewBag.TopProductLabels = new List<string>
        {
            "Romper Longer - Cream [0-3]",
            "Bodysuit - Light Blue [3-6]",
            "Romper Short - Sage Green [0-3]",
            "Bodysuit - Coffee [12-18]",
            "Set Kids - White [3-6]"
        };

                ViewBag.TopProductData = new List<int> { 230, 180, 150, 120, 95 };

                ViewBag.MovingAverageLabels = new List<string>
        {
            "01/06", "02/06", "03/06", "04/06", "05/06", "06/06", "07/06"
        };

                ViewBag.MovingAverageData = new List<double>
        {
            15, 18, 20, 22, 25, 27, 30
        };

                ViewBag.LatestMovingAverage = 30;

                ViewBag.ForecastStatus = "Safe";
                ViewBag.ForecastMessage =
                    "Dữ liệu demo cho thấy trung bình trượt 7 ngày đang ở mức 30 chiếc/ngày. Nhu cầu sản xuất tương đối ổn định, hệ thống đề xuất tiếp tục theo dõi nhóm phôi Romper Longer và Bodysuit.";
            }

            ViewBag.Rooms = await _context.Rooms.AsNoTracking().ToListAsync();
            ViewBag.Shops = await _context.Shops.AsNoTracking().ToListAsync();
            ViewBag.FromDate = fromDate.Value.ToString("yyyy-MM-dd");
            ViewBag.ToDate = toDate.Value.ToString("yyyy-MM-dd");

            return View();
        }
    }
}