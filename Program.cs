using DOAN_BTF.Models;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Authentication.Cookies;
using Microsoft.AspNetCore.Identity;
using DOAN_BTF.Services.ML;
var builder = WebApplication.CreateBuilder(args);

builder.Services.AddDbContext<DOAN_BTF_Context>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
// Password hasher
builder.Services.AddScoped<IPasswordHasher<User>, PasswordHasher<User>>();
builder.Services.AddScoped<MlTrainingService>();
// Add cookie authentication
// Add cookie authentication
builder.Services.AddAuthentication(CookieAuthenticationDefaults.AuthenticationScheme)
    .AddCookie(options =>
    {
        options.LoginPath = "/Account/Login";
        options.AccessDeniedPath = "/Account/Login";
        options.ExpireTimeSpan = TimeSpan.FromHours(8);

        // 🌟 BẮT BUỘC BỔ SUNG DÒNG NÀY ĐỂ ĐỒNG BỘ CLAIMS ROLE VỚI SIDEBAR
        options.Cookie.Name = "BTF_Embroidery_Auth";
    });


builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();
 
app.UseRouting();

app.UseAuthentication(); // <- bắt buộc
app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Account}/{action=Login}/{id?}");

// Seed admin nếu chưa có user
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var db = services.GetRequiredService<DOAN_BTF_Context>();
    var hasher = services.GetRequiredService<IPasswordHasher<User>>();

    if (!db.Users.Any())
    {
        var admin = new User { Username = "admin", Role = 1, RoomId = null };
        admin.Password = hasher.HashPassword(admin, "Admin123!");
        db.Users.Add(admin);
        db.SaveChanges();
    }
}
app.Run();
