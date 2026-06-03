using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using DOAN_BTF.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;

namespace DOAN_BTF.Controllers
{
    [Authorize(Roles = "Admin")]
    public class UsersController : Controller
    {
        private readonly DOAN_BTF_Context _context;
        private readonly PasswordHasher<User> _hasher = new();

        public UsersController(DOAN_BTF_Context context)
        {
            _context = context;
        }

        // GET: Users
        public async Task<IActionResult> Index()
        {
            var users = await _context.Users.Include(u => u.Room).ToListAsync();
            return View(users);
        }

        // GET: Users/Details/5
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null) return NotFound();
            var user = await _context.Users.Include(u => u.Room).FirstOrDefaultAsync(u => u.Id == id);
            if (user == null) return NotFound();
            return View(user);
        }

        // GET: Users/Create
        public IActionResult Create()
        {
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName");
            return View();
        }

        // POST: Users/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Create([Bind("Username,Password,Role,RoomId")] User user)
        {
            if (!ModelState.IsValid)
            {
                ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", user.RoomId);
                return View(user);
            }

            // hash password
            if (string.IsNullOrWhiteSpace(user.Password))
            {
                ModelState.AddModelError("", "Password is required.");
                ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", user.RoomId);
                return View(user);
            }

            var hashed = _hasher.HashPassword(user, user.Password);
            user.Password = hashed;

            _context.Add(user);
            await _context.SaveChangesAsync();
            return RedirectToAction(nameof(Index));
        }

        // GET: Users/Edit/5
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null) return NotFound();
            var user = await _context.Users.FindAsync(id);
            if (user == null) return NotFound();
            ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", user.RoomId);
            return View(user);
        }

        // POST: Users/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Username,Password,Role,RoomId")] User input)
        {
            if (id != input.Id) return NotFound();

            var user = await _context.Users.FindAsync(id);
            if (user == null) return NotFound();

            if (!ModelState.IsValid)
            {
                ViewData["RoomId"] = new SelectList(_context.Rooms, "Id", "RoomName", input.RoomId);
                return View(input);
            }

            user.Username = input.Username;
            user.Role = input.Role;
            user.RoomId = input.RoomId;

            // If a new password entered, hash and update; otherwise keep existing hash
            if (!string.IsNullOrWhiteSpace(input.Password))
            {
                user.Password = _hasher.HashPassword(user, input.Password);
            }

            try
            {
                _context.Update(user);
                await _context.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!_context.Users.Any(e => e.Id == user.Id)) return NotFound();
                throw;
            }

            return RedirectToAction(nameof(Index));
        }

        // GET: Users/Delete/5
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null) return NotFound();
            var user = await _context.Users.Include(u => u.Room).FirstOrDefaultAsync(u => u.Id == id);
            if (user == null) return NotFound();
            return View(user);
        }

        // POST: Users/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var user = await _context.Users.FindAsync(id);
            if (user != null)
            {
                _context.Users.Remove(user);
                await _context.SaveChangesAsync();
            }
            return RedirectToAction(nameof(Index));
        }
    }
}
