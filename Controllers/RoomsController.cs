    using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using DOAN_BTF.Models;

namespace DOAN_BTF.Controllers
{
    public class RoomsController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public RoomsController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: Rooms
        public async Task<IActionResult> Index(int? roomId)
        {
            // Nạp danh sách phòng ban kèm số lượng shop trực thuộc để hiển thị lên Badge giao diện
            var rooms = await _context.Rooms
                .Include(r => r.Shops)
                .AsNoTracking()
                .ToListAsync();

            // Lọc danh sách shop theo phòng ban được lựa chọn linh hoạt
            var shops = await _context.Shops
                .Include(s => s.Room)
                .Where(s => roomId == null || s.RoomId == roomId)
                .AsNoTracking()
                .ToListAsync();

            // Khởi tạo đối tượng lưu trữ dữ liệu truyền ra View gộp
            var vm = new RoomShopViewModel
            {
                Rooms = rooms,
                Shops = shops,
                SelectedRoomId = roomId
            };

            return View(vm);
        }

        // GET: Rooms/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Rooms/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,RoomName")] Room room)
        {
            if (ModelState.IsValid)
            {
                _context.Add(room);
                await _context.SaveChangesAsync();
                TempData["Success"] = "Thêm phòng ban mới thành công.";
                return RedirectToAction(nameof(Index));
            }
            return View(room);
        }

        // GET: Rooms/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null) return NotFound();

            var room = await _context.Rooms.FindAsync(id);
            if (room == null) return NotFound();

            return View(room);
        }

        // POST: Rooms/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,RoomName")] Room room)
        {
            if (id != room.Id) return NotFound();

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(room);
                    await _context.SaveChangesAsync();
                    TempData["Success"] = "Cập nhật tên phòng ban thành công.";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RoomExists(room.Id)) return NotFound();
                    else throw;
                }
                return RedirectToAction(nameof(Index));
            }
            return View(room);
        }

        // POST: Rooms/Delete/5 (Đã nâng cấp: Kiểm tra ràng buộc dữ liệu thông minh)
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var room = await _context.Rooms.FindAsync(id);
            if (room == null) return NotFound();

            // 🔒 BẢO VỆ DỮ LIỆU: Kiểm tra xem phòng ban có đang chứa nhân viên hoặc shop nào không
            bool hasUsers = await _context.Users.AnyAsync(u => u.RoomId == id);
            bool hasShops = await _context.Shops.AnyAsync(s => s.RoomId == id);
            bool hasOrders = await _context.Orders.AnyAsync(o => o.RoomId == id);

            if (hasUsers || hasShops || hasOrders)
            {
                TempData["Error"] = "Không thể xóa phòng ban này vì hệ thống đang lưu trữ dữ liệu nhân sự, đơn hàng hoặc shop thuộc phòng ban này.";
                return RedirectToAction(nameof(Index));
            }

            try
            {
                _context.Rooms.Remove(room);
                await _context.SaveChangesAsync();
                TempData["Success"] = "Xóa phòng ban thành công khỏi hệ thống.";
            }
            catch (Exception)
            {
                TempData["Error"] = "Đã xảy ra lỗi xung đột hệ thống dữ liệu, không thể hoàn tác thao tác xóa.";
            }

            return RedirectToAction(nameof(Index));
        }

        private bool RoomExists(int id)
        {
            return _context.Rooms.Any(e => e.Id == id);
        }
    }
}