using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DOAN_BTF.Models;
using System;
using System.Linq;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace DOAN_BTF.Controllers
{
    public class HomeController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public HomeController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        public async Task<IActionResult> Index()
        {
            // =========================
            // 1. KPI CARD
            // =========================

            ViewBag.RunningOrders = await _context.Orders
                .CountAsync(o =>
                    o.Status == OrderStatusConst.ChoTheu ||
                    o.Status == OrderStatusConst.DangTheu);

            ViewBag.LowStockCount = await _context.Inventories
                .CountAsync(i => (i.Quantity ?? 0) <= 5);

            ViewBag.ReadyOrders = await _context.Orders
                .CountAsync(o => o.Status == OrderStatusConst.HoanThanh);


            // =========================
            // 2. ĐƠN HÀNG GẦN ĐÂY
            // =========================

            ViewBag.RecentOrders = await _context.Orders
                .Include(o => o.Shop)
                .Include(o => o.Room)
                .OrderByDescending(o => o.CreateAt)
                .Take(5)
                .ToListAsync();


            // =========================
            // 3. PHÔI ÁO SẮP HẾT
            // =========================

            ViewBag.LowStockItems = await _context.Inventories
                .Include(i => i.ProductVariant)
                    .ThenInclude(pv => pv.Product)
                .Where(i => (i.Quantity ?? 0) <= 5)
                .OrderBy(i => i.Quantity)
                .Take(5)
                .ToListAsync();


            // =========================
            // 4. BIỂU ĐỒ TRÒN TRẠNG THÁI SẢN XUẤT
            // =========================

            ViewBag.CountChuaCoAo = await _context.Orders
                .CountAsync(o => o.Status == OrderStatusConst.Chuacoao);

            ViewBag.CountChoTheu = await _context.Orders
                .CountAsync(o => o.Status == OrderStatusConst.ChoTheu);

            ViewBag.CountDangTheu = await _context.Orders
                .CountAsync(o => o.Status == OrderStatusConst.DangTheu);

            ViewBag.CountHoanThanh = await _context.Orders
                .CountAsync(o => o.Status == OrderStatusConst.HoanThanh);

            ViewBag.CountHuy = await _context.Orders
                .CountAsync(o => o.Status == OrderStatusConst.Huy);


            // =========================
            // 5. BIỂU ĐỒ CỘT SẢN LƯỢNG 7 NGÀY GẦN NHẤT
            // Dựa trên đơn có trạng thái Hoàn thành
            // =========================

            var today = DateTime.Today;
            var last7Days = Enumerable.Range(0, 7)
                .Select(i => today.AddDays(-6 + i))
                .ToList();

            var completedOrders = await _context.Orders
                .Include(o => o.OrderDetails)
                .Where(o =>
                    o.Status == OrderStatusConst.HoanThanh &&
                    o.CreateAt.HasValue &&
                    o.CreateAt.Value.Date >= last7Days.First() &&
                    o.CreateAt.Value.Date <= last7Days.Last())
                .ToListAsync();

            var chartLabels = new List<string>();
            var chartData = new List<int>();

            foreach (var day in last7Days)
            {
                chartLabels.Add(day.ToString("dd/MM"));

                var totalQtyInDay = completedOrders
                    .Where(o => o.CreateAt.HasValue && o.CreateAt.Value.Date == day)
                    .Sum(o => o.OrderDetails.Sum(d => d.Quantity ?? 0));

                chartData.Add(totalQtyInDay);
            }

            ViewBag.WeeklyLabels = chartLabels;
            ViewBag.WeeklyData = chartData;


            // =========================
            // 6. TOP SHOP NHIỀU ĐƠN
            // =========================

            ViewBag.TopShops = await _context.Orders
                .Include(o => o.Shop)
                .Where(o => o.Shop != null)
                .GroupBy(o => o.Shop.ShopName)
                .Select(g => new
                {
                    ShopName = g.Key,
                    Count = g.Count()
                })
                .OrderByDescending(x => x.Count)
                .Take(5)
                .ToListAsync();


            // =========================
            // 7. TOP SẢN PHẨM / MẪU PHÔI
            // =========================

            ViewBag.TopProducts = await _context.OrderDetails
                .Include(d => d.ProductVariant)
                    .ThenInclude(v => v.Product)
                .Where(d => d.ProductVariant != null)
                .GroupBy(d => new
                {
                    ProductName = d.ProductVariant.Product.ProductName,
                    Color = d.ProductVariant.Color,
                    Size = d.ProductVariant.Size
                })
                .Select(g => new
                {
                    Name = g.Key.ProductName,
                    Color = g.Key.Color,
                    Size = g.Key.Size,
                    Quantity = g.Sum(x => x.Quantity ?? 0)
                })
                .OrderByDescending(x => x.Quantity)
                .Take(5)
                .ToListAsync();


            return View();
        }
    }
}