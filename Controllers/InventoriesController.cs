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
    public class InventoriesController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public InventoriesController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: Inventories
        public async Task<IActionResult> Index(string search, string color, string size)
        {
            var query = _context.Inventories
                .Include(i => i.ProductVariant)
                    .ThenInclude(p => p.Product)
                .AsQueryable();

            // SEARCH tên sản phẩm
            if (!string.IsNullOrWhiteSpace(search))
            {
                var keyword = search.Trim().ToLower();

                query = query.Where(i =>
                    i.ProductVariant.Product.ProductName.ToLower().Contains(keyword));
            }

            // FILTER màu
            if (!string.IsNullOrWhiteSpace(color))
            {
                query = query.Where(i => i.ProductVariant.Color == color);
            }

            // FILTER size
            if (!string.IsNullOrWhiteSpace(size))
            {
                query = query.Where(i => i.ProductVariant.Size == size);
            }

            ViewBag.Products = await _context.Products
    .OrderBy(x => x.ProductName)
    .ToListAsync();

            ViewBag.Colors = await _context.ProductVariants
                .Select(x => x.Color)
                .Distinct()
                .ToListAsync();

            ViewBag.Sizes = await _context.ProductVariants
                .Select(x => x.Size)
                .Distinct()
                .ToListAsync();

            ViewBag.Search = search;
            ViewBag.SelectedColor = color;
            ViewBag.SelectedSize = size;

            return View(await query.ToListAsync());
        }

        // GET: Inventories/Logs (Xem lịch sử xuất nhập kho xưởng thêu)
        public async Task<IActionResult> Logs()
        {
            var logs = await _context.InventoryLogs
                .Include(x => x.ProductVariant)
                    .ThenInclude(x => x.Product)
                .OrderByDescending(x => x.CreateAt)
                .AsNoTracking()
                .ToListAsync();

            return View(logs);
        }

        // GET: Inventories/Create (Giao diện Nhập phôi áo)
        public async Task<IActionResult> Create()
        {
            await PopulateVariantDropdown();
            return View();
        }

        // POST: Inventories/Create (Xử lý Nhập kho - Đã sửa lỗi mất đồng bộ)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create(Inventory inventory)
        {
            if (inventory.Quantity <= 0)
            {
                TempData["Error"] = "Số lượng nhập kho phải lớn hơn 0";
                return RedirectToAction(nameof(Index));
            }

            if (ModelState.IsValid)
            {
                var existingInventory = await _context.Inventories
                    .FirstOrDefaultAsync(x => x.ProductVariantId == inventory.ProductVariantId);

                if (existingInventory != null)
                {
                    // Cộng dồn vào lô hàng phôi áo cũ
                    existingInventory.Quantity = (existingInventory.Quantity ?? 0) + (inventory.Quantity ?? 0);
                    _context.Inventories.Update(existingInventory);
                }
                else
                {
                    // Tạo mới nếu loại phôi này chưa từng nhập kho
                    _context.Inventories.Add(inventory);
                }

                // Lưu vết lịch sử Nhập kho (Type = 1)
                _context.InventoryLogs.Add(new InventoryLog
                {
                    ProductVariantId = inventory.ProductVariantId,
                    Quantity = inventory.Quantity,
                    Type = (int)InventoryLogType.Import,
                    CreateAt = DateTime.Now
                });

                await _context.SaveChangesAsync();
                TempData["Success"] = "Nhập phôi áo vào kho thành công.";
                return RedirectToAction(nameof(Index));
            }

            await PopulateVariantDropdown();
            return View(inventory);
        }

        // GET: Inventories/Export (Giao diện Xuất kho đi thêu)
        public async Task<IActionResult> Export()
        {
            await PopulateVariantDropdown();
            return View();
        }

        // POST: Inventories/Export (Xử lý Xuất kho thêu - Đã sửa lỗi không trừ số lượng tồn)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Export(int ProductVariantId, int Quantity)
        {
            if (Quantity <= 0)
            {
                TempData["Error"] = "Số lượng xuất kho phải lớn hơn 0";
                return RedirectToAction(nameof(Index));
            }

            var inventory = await _context.Inventories
                .FirstOrDefaultAsync(x => x.ProductVariantId == ProductVariantId);

            if (inventory == null)
            {
                TempData["Error"] = "Không tìm thấy cấu hình phôi sản phẩm này trong kho";
                return RedirectToAction(nameof(Index));
            }

            // RÀNG BUỘC AN TOÀN: Ngăn chặn âm kho
            if ((inventory.Quantity ?? 0) < Quantity)
            {
                TempData["Error"] = $"Số lượng tồn phôi trong kho hiện tại ({inventory.Quantity}) không đủ để xuất lượng yêu cầu ({Quantity})";
                return RedirectToAction(nameof(Index));
            }

            // Thực hiện trừ kho thực tế
            inventory.Quantity -= Quantity;
            _context.Inventories.Update(inventory); // 🔥 FIX: Bổ sung lệnh đồng bộ trừ số lượng tồn

            // Lưu vết lịch sử Xuất kho thêu (Type = 2)
            _context.InventoryLogs.Add(new InventoryLog
            {
                ProductVariantId = ProductVariantId,
                Quantity = Quantity,
                Type = (int)InventoryLogType.Export,
                CreateAt = DateTime.Now
            });

            await _context.SaveChangesAsync();
            TempData["Success"] = "Xuất kho phôi áo đi sản xuất thêu thành công.";

            return RedirectToAction(nameof(Index));
        }

        // HÀM BỔ TRỢ: Gom gọn logic nạp dropdown Màu/Size phôi
        private async Task PopulateVariantDropdown()
        {
            var variants = await _context.ProductVariants
                .Include(x => x.Product)
                .Select(x => new
                {
                    Id = x.Id,
                    Name = (x.Product != null ? x.Product.ProductName : "") + " - " + x.Color + " [" + x.Size + "]"
                })
                .ToListAsync();

            ViewData["ProductVariantId"] = new SelectList(variants, "Id", "Name");
        }
    }
}