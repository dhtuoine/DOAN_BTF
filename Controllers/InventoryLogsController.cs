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
    public class InventoryLogsController : Controller
    {
        private readonly DOAN_BTF_Context _context;

        public InventoryLogsController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: InventoryLogs
        public async Task<IActionResult> Index()
        {
            var dOAN_BTF_Context = _context.InventoryLogs.Include(i => i.ProductVariant);
            return View(await dOAN_BTF_Context.ToListAsync());
        }

        // GET: InventoryLogs/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var inventoryLog = await _context.InventoryLogs
                .Include(i => i.ProductVariant)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (inventoryLog == null)
            {
                return NotFound();
            }

            return View(inventoryLog);
        }

        // GET: InventoryLogs/Create
        public IActionResult Create()
        {
            ViewData["ProductVariantId"] = new SelectList(_context.ProductVariants, "Id", "Id");
            return View();
        }

        // POST: InventoryLogs/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Id,ProductVariantId,Quantity,Type,CreateAt")] InventoryLog inventoryLog)
        {
            if (ModelState.IsValid)
            {
                _context.Add(inventoryLog);
                await _context.SaveChangesAsync();
                return RedirectToAction(nameof(Index));
            }
            ViewData["ProductVariantId"] = new SelectList(_context.ProductVariants, "Id", "Id", inventoryLog.ProductVariantId);
            return View(inventoryLog);
        }

        // GET: InventoryLogs/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var inventoryLog = await _context.InventoryLogs.FindAsync(id);
            if (inventoryLog == null)
            {
                return NotFound();
            }
            ViewData["ProductVariantId"] = new SelectList(_context.ProductVariants, "Id", "Id", inventoryLog.ProductVariantId);
            return View(inventoryLog);
        }

        // POST: InventoryLogs/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to.
        // For more details, see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,ProductVariantId,Quantity,Type,CreateAt")] InventoryLog inventoryLog)
        {
            if (id != inventoryLog.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(inventoryLog);
                    await _context.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!InventoryLogExists(inventoryLog.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            ViewData["ProductVariantId"] = new SelectList(_context.ProductVariants, "Id", "Id", inventoryLog.ProductVariantId);
            return View(inventoryLog);
        }

        // GET: InventoryLogs/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var inventoryLog = await _context.InventoryLogs
                .Include(i => i.ProductVariant)
                .FirstOrDefaultAsync(m => m.Id == id);
            if (inventoryLog == null)
            {
                return NotFound();
            }

            return View(inventoryLog);
        }

        // POST: InventoryLogs/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var inventoryLog = await _context.InventoryLogs.FindAsync(id);
            if (inventoryLog != null)
            {
                _context.InventoryLogs.Remove(inventoryLog);
            }

            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        private bool InventoryLogExists(int id)
        {
            return _context.InventoryLogs.Any(e => e.Id == id);
        }
    }
}
