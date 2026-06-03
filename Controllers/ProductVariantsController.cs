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
    public class ProductVariantsController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public ProductVariantsController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // POST: ProductVariants/Create - Tự động đồng bộ dữ liệu sang bảng Kho hàng (Inventory)
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,ProductId,Color,Size")] ProductVariant productVariant)
        {
            if (ModelState.IsValid)
            {
                // Kiểm tra chống trùng lặp cấu hình phôi áo thêu
                bool isExist = await _context.ProductVariants.AnyAsync(v =>
                    v.ProductId == productVariant.ProductId &&
                    v.Color.ToLower() == productVariant.Color.Trim().ToLower() &&
                    v.Size.ToLower() == productVariant.Size.Trim().ToLower());

                if (isExist)
                {
                    TempData["Error"] = $"Biến thể màu sắc và kích cỡ này đã tồn tại trong hệ thống.";
                    return RedirectToAction("Index", "Products");
                }

                productVariant.Color = productVariant.Color.Trim();
                productVariant.Size = productVariant.Size.Trim();

                _context.Add(productVariant);
                await _context.SaveChangesAsync();

                // 🔥 ĐIỂM CỘNG LỚN: Tự động khởi tạo dòng dữ liệu tồn kho bằng 0 cho biến thể mới
                var emptyInventory = new Inventory
                {
                    ProductVariantId = productVariant.Id,
                    Quantity = 0 // Mới tạo phôi thì số lượng mặc định trong kho bằng 0
                };
                _context.Inventories.Add(emptyInventory);
                await _context.SaveChangesAsync();

                TempData["Success"] = "Thêm biến thể Màu/Size mới thành công. Bản ghi kho hàng đã được đồng bộ.";
                return RedirectToAction("Index", "Products");
            }
            return RedirectToAction("Index", "Products");
        }
        // GET: ProductVariants/Create
        public IActionResult Create(int productId)
        {
            var product = _context.Products.Find(productId);

            if (product == null)
            {
                return NotFound();
            }

            var variant = new ProductVariant
            {
                ProductId = productId
            };

            ViewBag.ProductName = product.ProductName;

            return View(variant);
        }
        // POST: ProductVariants/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,ProductId,Color,Size")] ProductVariant productVariant)
        {
            if (id != productVariant.Id) return NotFound();

            if (ModelState.IsValid)
            {
                try
                {
                    productVariant.Color = productVariant.Color.Trim();
                    productVariant.Size = productVariant.Size.Trim();

                    _context.Update(productVariant);
                    await _context.SaveChangesAsync();
                    TempData["Success"] = "Cập nhật cấu hình biến thể phôi áo thành công.";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!_context.ProductVariants.Any(e => e.Id == productVariant.Id)) return NotFound();
                    else throw;
                }
                return RedirectToAction("Index", "Products");
            }
            return RedirectToAction("Index", "Products");
        }

        // POST: ProductVariants/Delete/5 - Sửa lỗi dọn dẹp bảng Inventory liên đới
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var productVariant = await _context.ProductVariants.FindAsync(id);

            if (productVariant == null)
                return NotFound();

            bool hasOrders = await _context.OrderDetails
                .AnyAsync(o => o.ProductVariantId == id);

            if (hasOrders)
            {
                TempData["Error"] = "Không thể xóa vì biến thể đã nằm trong đơn hàng.";
                return RedirectToAction("Index", "Products");
            }

            try
            {
                var associatedInvs = _context.Inventories
                    .Where(i => i.ProductVariantId == id);

                _context.Inventories.RemoveRange(associatedInvs);

                _context.ProductVariants.Remove(productVariant);

                await _context.SaveChangesAsync();

                TempData["Success"] = "Xóa biến thể thành công.";
            }
            catch (Exception)
            {
                TempData["Error"] = "Lỗi hệ thống.";
            }

            return RedirectToAction("Index", "Products");
        }
    }
}