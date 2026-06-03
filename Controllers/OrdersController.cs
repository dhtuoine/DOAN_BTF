using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DOAN_BTF.Models;

namespace DOAN_BTF.Controllers
{
    public class OrdersController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public OrdersController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: Orders
        public async Task<IActionResult> Index(string search, string status, int? shopId, int page = 1)
        {
            int pageSize = 5;
            if (page < 1) page = 1;

            ViewBag.Shops = await _context.Shops.OrderBy(x => x.ShopName).ToListAsync();

            var query = _context.Orders
                .AsNoTracking()
                .Include(o => o.Room)
                .Include(o => o.Shop)
                .Include(o => o.OrderDetails)
                .ThenInclude(d => d.ProductVariant)
                .AsQueryable();

            if (User.Identity?.IsAuthenticated == true)
            {
                if (User.IsInRole("Sales"))
                {
                    var roomClaim = User.FindFirst("RoomId")?.Value;
                    if (int.TryParse(roomClaim, out var roomId)) query = query.Where(o => o.RoomId == roomId);
                    else query = query.Where(o => false);
                }
            }

            if (!string.IsNullOrWhiteSpace(search))
            {
                var keyword = search.Trim().ToLower();
                query = query.Where(o => (o.OrderCode ?? "").ToLower().Contains(keyword) || (o.CustomerName ?? "").ToLower().Contains(keyword) || (o.PhoneNumber ?? "").ToLower().Contains(keyword));
            }

            if (!string.IsNullOrWhiteSpace(status)) query = query.Where(o => o.Status == status);
            if (shopId.HasValue) query = query.Where(o => o.ShopId == shopId.Value);

            int totalItems = await query.CountAsync();
            var orders = await query.OrderByDescending(o => o.CreateAt).Skip((page - 1) * pageSize).Take(pageSize).ToListAsync();

            ViewBag.CurrentPage = page;
            ViewBag.TotalPages = (int)Math.Ceiling((double)totalItems / pageSize);
            ViewBag.Search = search;
            ViewBag.Status = status;
            ViewBag.ShopId = shopId;

            return View(orders);
        }

        public async Task<IActionResult> Details(int? id)
        {
            if (id == null) return NotFound();
            var order = await _context.Orders.Include(o => o.Room).Include(o => o.Shop).FirstOrDefaultAsync(m => m.Id == id);
            return order == null ? NotFound() : View(order);
        }

        public IActionResult Create()
        {
            ViewBag.Products = _context.Products.ToList();
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName");
            ViewData["ShopId"] = new SelectList(_context.Shops, "Id", "ShopName");
            var variants = _context.ProductVariants.Include(v => v.Product).Select(v => new { v.Id, Name = (v.Product != null ? v.Product.ProductName : "") + " - " + v.Color + " " + v.Size }).ToList();
            ViewData["ProductVariantId"] = new SelectList(variants, "Id", "Name");
            var vm = new OrderCreateViewModel { OrderDetails = new List<OrderDetail> { new OrderDetail() } };
            return View(vm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(OrderCreateViewModel vm)
        {
            if (ModelState.IsValid)
            {
                var order = new Order { OrderCode = vm.OrderCode, CustomerName = vm.CustomerName, PhoneNumber = vm.PhoneNumber, Address = vm.Address, Country = vm.Country, ShopId = vm.ShopId, RoomId = vm.RoomId, Status = OrderStatusConst.ChoTheu, CreateAt = DateTime.Now };
                _context.Orders.Add(order);
                await _context.SaveChangesAsync();
                foreach (var d in vm.OrderDetails)
                {
                    if (d.ProductVariantId <= 0 || d.Quantity <= 0) continue;
                    d.OrderId = order.Id;
                    _context.OrderDetails.Add(d);
                }
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            return View(vm);
        }

        [HttpPost]
        public async Task<IActionResult> UpdateStatus(int id, string status)
        {
            var order = await _context.Orders.Include(o => o.OrderDetails).FirstOrDefaultAsync(o => o.Id == id);
            if (order == null) return NotFound();
            if (!User.IsInRole("Embroidery")) return Forbid();

            // Logic: Nếu chuyển sang "Đang thêu" thì mới trừ kho
            if (status == "Đang thêu" && order.Status != "Đang thêu")
            {
                foreach (var item in order.OrderDetails)
                {
                    var inv = await _context.Inventories.FirstOrDefaultAsync(i => i.ProductVariantId == item.ProductVariantId);
                    if (inv == null || inv.Quantity < item.Quantity) return BadRequest("Không đủ phôi cho biến thể ID: " + item.ProductVariantId);
                }

                using (var transaction = await _context.Database.BeginTransactionAsync())
                {
                    foreach (var item in order.OrderDetails)
                    {
                        var inv = await _context.Inventories.FirstOrDefaultAsync(i => i.ProductVariantId == item.ProductVariantId);
                        inv.Quantity -= item.Quantity;
                        _context.InventoryLogs.Add(new InventoryLog { ProductVariantId = item.ProductVariantId,Quantity = -item.Quantity, CreateAt = DateTime.Now });
                    }
                    order.Status = status;
                    await _context.SaveChangesAsync();
                    await transaction.CommitAsync();
                }
            }
            else
            {
                order.Status = status;
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }

        // GET: Orders/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var order = await _context.Orders
                .Include(o => o.OrderDetails)
                .FirstOrDefaultAsync(o => o.Id == id);

            if (order == null)
            {
                return NotFound();
            }

            ViewBag.Products = _context.Products.ToList();
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", order.RoomId);
            ViewData["ShopId"] = new SelectList(_context.Shops, "Id", "ShopName", order.ShopId);

            var vm = new OrderCreateViewModel
            {
                Id = order.Id,
                OrderCode = order.OrderCode,
                CustomerName = order.CustomerName,
                PhoneNumber = order.PhoneNumber,
                Address = order.Address,
                Country = order.Country,
                RoomId = order.RoomId,
                ShopId = order.ShopId,
                OrderDetails = order.OrderDetails.ToList()
            };

            return View(vm);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, OrderCreateViewModel vm)
        {
            if (id != vm.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                var order = await _context.Orders
                    .Include(o => o.OrderDetails)
                    .FirstOrDefaultAsync(o => o.Id == id);

                if (order == null)
                {
                    return NotFound();
                }

                order.OrderCode = vm.OrderCode;
                order.CustomerName = vm.CustomerName;
                order.PhoneNumber = vm.PhoneNumber;
                order.Address = vm.Address;
                order.Country = vm.Country;
                order.RoomId = vm.RoomId;
                order.ShopId = vm.ShopId;

                // Xóa detail cũ
                _context.OrderDetails.RemoveRange(order.OrderDetails);

                // Thêm detail mới
                foreach (var item in vm.OrderDetails)
                {
                    item.OrderId = order.Id;
                    _context.OrderDetails.Add(item);
                }

                await _context.SaveChangesAsync();

                return RedirectToAction(nameof(Index));
            }

            ViewBag.Products = _context.Products.ToList();
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", vm.RoomId);
            ViewData["ShopId"] = new SelectList(_context.Shops, "Id", "ShopName", vm.ShopId);

            return View(vm);
        }
    }
}