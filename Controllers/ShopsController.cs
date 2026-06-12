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
    public class ShopsController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public ShopsController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: Shops/Create
        public IActionResult Create(int? roomId)
        {
            if (User.IsInRole("Sales") )
            {
                var roomClaim = User.FindFirst("RoomId")?.Value;

                if (!int.TryParse(roomClaim, out var salesRoomId))
                    return Forbid();

                ViewBag.LockedRoomId = salesRoomId;

                ViewData["RoomId"] = new SelectList(
                    _context.Rooms.Where(r => r.Id == salesRoomId),
                    "Id",
                    "RoomName",
                    salesRoomId
                );
            }
            else
            {
                ViewBag.LockedRoomId = roomId;

                ViewData["RoomId"] = new SelectList(
                    _context.Rooms.OrderBy(r => r.RoomName),
                    "Id",
                    "RoomName",
                    roomId
                );
            }

            return View();

        }

        // POST: Shops/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,ShopName,RoomId")] Shop shop)
        {
            if (User.IsInRole("Sales") && !User.IsInRole("Admin"))
            {
                var roomClaim = User.FindFirst("RoomId")?.Value;

                if (!int.TryParse(roomClaim, out var salesRoomId))
                    return Forbid();

                shop.RoomId = salesRoomId;
            }

            if (ModelState.IsValid)
            {
                _context.Add(shop);
                await _context.SaveChangesAsync();
                TempData["Success"] = $"Thêm shop '{shop.ShopName}' thành công.";

                // Trả về đúng luồng Phòng ban đang xem
                return RedirectToAction("Index", "Rooms", new { roomId = shop.RoomId });
            }
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", shop.RoomId);
            return View(shop);
        }

        // GET: Shops/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null) return NotFound();

            var shop = await _context.Shops.FindAsync(id);
            if (shop == null) return NotFound();

            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", shop.RoomId);
            return View(shop);
        }

        // POST: Shops/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,ShopName,RoomId")] Shop shop)
        {
            if (id != shop.Id) return NotFound();

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(shop);
                    await _context.SaveChangesAsync();
                    TempData["Success"] = "Cập nhật thông tin shop thành công.";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ShopExists(shop.Id)) return NotFound();
                    else throw;
                }
                // Trả về đúng phòng ban quản lý shop này sau khi sửa xong
                return RedirectToAction("Index", "Rooms", new { roomId = shop.RoomId });
            }
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", shop.RoomId);
            return View(shop);
        }

        // POST: Shops/Delete/5 (Sửa lỗi bảo vệ và giữ định tuyến URL)
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ActionName("Delete")]
        public async Task<IActionResult> Delete(int id)
        {
            var shop = await _context.Shops.FindAsync(id);

            if (shop == null)
                return NotFound();

            int? targetRoomId = shop.RoomId;

            bool hasOrders = await _context.Orders
                .AnyAsync(o => o.ShopId == id);

            if (hasOrders)
            {
                TempData["Error"] =
                    $"Không thể xóa shop '{shop.ShopName}' vì đang có đơn hàng.";

                return RedirectToAction("Index", "Rooms",
                    new { roomId = targetRoomId });
            }

            try
            {
                _context.Shops.Remove(shop);

                await _context.SaveChangesAsync();

                TempData["Success"] = "Xóa cửa hàng thành công.";
            }
            catch (Exception)
            {
                TempData["Error"] =
                    "Lỗi dữ liệu, không thể xóa.";
            }

            return RedirectToAction("Index", "Rooms",
                new { roomId = targetRoomId });
        }

        private bool ShopExists(int id)
        {
            return _context.Shops.Any(e => e.Id == id);
        }
    }
}