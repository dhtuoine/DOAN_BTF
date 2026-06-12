using DOAN_BTF.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace DOAN_BTF.Controllers
{
    [Authorize(Roles = "Admin")]
    public class ProductsController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public ProductsController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: Products - Đã tối ưu hóa câu lệnh nạp kèm dữ liệu (Eager Loading)
        public async Task<IActionResult> Index(string search)
        {
            var query = _context.Products
                .Include(p => p.ProductVariants) // Nạp kèm danh sách màu/size để đổ ra Card lưới
                .AsNoTracking()
                .AsQueryable();

            if (!string.IsNullOrWhiteSpace(search))
            {
                var keyword = search.Trim().ToLower();
                query = query.Where(p => p.ProductName.ToLower().Contains(keyword));
            }

            var products = await query.OrderBy(p => p.ProductName).ToListAsync();
            ViewBag.Search = search;

            return View(products);
        }

        // GET: Products/Create
        public IActionResult Create()
        {
            return View();
        }

        // POST: Products/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,ProductName")] Product product)
        {
            if (ModelState.IsValid)
            {
                _context.Add(product);
                await _context.SaveChangesAsync();
                TempData["Success"] = $"Thêm sản phẩm '{product.ProductName}' thành công! Hãy tạo thêm các biến thể Màu và Size.";
                return RedirectToAction(nameof(Index));
            }
            return View(product);
        }

        // GET: Products/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null) return NotFound();
            var product = await _context.Products.FindAsync(id);
            if (product == null) return NotFound();
            return View(product);
        }

        // POST: Products/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,ProductName")] Product product)
        {
            if (id != product.Id) return NotFound();

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(product);
                    await _context.SaveChangesAsync();
                    TempData["Success"] = "Cập nhật tên sản phẩm gốc thành công.";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!productExists(product.Id)) return NotFound();
                    else throw;
                }
                return RedirectToAction(nameof(Index));
            }
            return View(product);
        }

        // POST: Products/Delete/5 - Tự động dọn dẹp biến thể mồ côi an toàn
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var product = await _context.Products
                .Include(p => p.ProductVariants)
                .FirstOrDefaultAsync(p => p.Id == id);

            if (product == null)
            {
                TempData["Error"] = "Sản phẩm không tồn tại!";
                return RedirectToAction(nameof(Index));
            }

            var variantIds = product.ProductVariants.Select(v => v.Id).ToList();

            bool hasOrders = await _context.OrderDetails
                .AnyAsync(o => variantIds.Contains(o.ProductVariantId ?? 0));

            if (hasOrders)
            {
                TempData["Error"] = "Sản phẩm đã tồn tại trong đơn hàng nên không thể xóa.";
                return RedirectToAction(nameof(Index));
            }

            var inventories = _context.Inventories
                .Where(i => variantIds.Contains(i.ProductVariantId ?? 0));

            _context.Inventories.RemoveRange(inventories);

            _context.ProductVariants.RemoveRange(product.ProductVariants);

            _context.Products.Remove(product);

            await _context.SaveChangesAsync();

            TempData["Success"] = "Xóa sản phẩm thành công.";

            return RedirectToAction(nameof(Index));
        }

        private bool productExists(int id)
        {
            return _context.Products.Any(e => e.Id == id);
        }
    }
}