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

            var primaryVariantId = topProducts.FirstOrDefault()?.VariantId;
            var primaryVelocity = topProducts.FirstOrDefault()?.TotalQty ?? 0;

            if (primaryVariantId.HasValue)
            {
                var currentStock = await _context.Inventories
                    .Where(i => i.ProductVariantId == primaryVariantId)
                    .Select(i => i.Quantity)
                    .FirstOrDefaultAsync() ?? 0;

                var alertVariant = await _context.ProductVariants
                    .Include(v => v.Product)
                    .FirstOrDefaultAsync(v => v.Id == primaryVariantId);

                if (currentStock <= primaryVelocity)
                {
                    ViewBag.ForecastStatus = "Danger";
                    ViewBag.ForecastMessage =
                        $"[CẢNH BÁO NHẬP HÀNG] Mẫu phôi '{alertVariant?.Product?.ProductName} - {alertVariant?.Color}' đang có nhu cầu cao nhất ({primaryVelocity} chiếc trong 30 ngày qua). Lượng tồn hiện tại còn {currentStock} chiếc. Hệ thống đề xuất nhập thêm ít nhất {Math.Max(50, primaryVelocity * 2)} phôi áo.";
                }
                else
                {
                    ViewBag.ForecastStatus = "Safe";
                    ViewBag.ForecastMessage =
                        "Hệ thống phân tích nhận thấy lượng phôi áo trong kho hiện tại đủ đáp ứng nhu cầu thêu của xưởng dựa trên tốc độ đơn hàng ổn định trong 30 ngày qua.";
                }
            }
            else
            {
                ViewBag.ForecastStatus = "Info";
                ViewBag.ForecastMessage =
                    "Chưa đủ dữ liệu đơn hàng trong khoảng thời gian này để đưa ra dự báo chính xác.";
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

                ViewBag.TopProductData = new List<int>
                {
                    230, 180, 150, 120, 95
                };

                ViewBag.ForecastStatus = "Safe";
                ViewBag.ForecastMessage =
                    "Dữ liệu demo cho thấy nhu cầu sản xuất đang ổn định. Nhóm Romper Longer và Bodysuit có tỷ lệ tiêu thụ cao, hệ thống đề xuất theo dõi tồn kho các nhóm phôi này để chuẩn bị nhập hàng khi cần.";
            }

            ViewBag.Rooms = await _context.Rooms.AsNoTracking().ToListAsync();
            ViewBag.Shops = await _context.Shops.AsNoTracking().ToListAsync();
            ViewBag.FromDate = fromDate.Value.ToString("yyyy-MM-dd");
            ViewBag.ToDate = toDate.Value.ToString("yyyy-MM-dd");

            return View();
        }
    }
}