using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class DOAN_BTF_Context : DbContext
{
    public DOAN_BTF_Context()
    {
    }

    public DOAN_BTF_Context(DbContextOptions<DOAN_BTF_Context> options)
        : base(options)
    {
    }

    public virtual DbSet<Inventory> Inventories { get; set; }

    public virtual DbSet<InventoryLog> InventoryLogs { get; set; }

    public virtual DbSet<Order> Orders { get; set; }

    public virtual DbSet<OrderDetail> OrderDetails { get; set; }

    public virtual DbSet<Product> Products { get; set; }

    public virtual DbSet<ProductVariant> ProductVariants { get; set; }

    public virtual DbSet<Room> Rooms { get; set; }

    public virtual DbSet<Shop> Shops { get; set; }

    public virtual DbSet<User> Users { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseSqlServer("Server=(localdb)\\MSSQLLocalDB;Database=DOAN_BTF_DB;Trusted_Connection=True;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Inventory>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Inventor__3214EC070569D928");

            entity.Property(e => e.Quantity).HasDefaultValue(0);

            entity.HasOne(d => d.ProductVariant).WithMany(p => p.Inventories).HasConstraintName("FK__Inventory__Produ__4F7CD00D");
        });

        modelBuilder.Entity<InventoryLog>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Inventor__3214EC072431FADE");

            entity.Property(e => e.CreateAt).HasDefaultValueSql("(getdate())");

            entity.HasOne(d => d.ProductVariant).WithMany(p => p.InventoryLogs).HasConstraintName("FK__Inventory__Produ__5070F446");
        });

        modelBuilder.Entity<Order>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Orders__3214EC07974D9DEB");

            entity.Property(e => e.CreateAt).HasDefaultValueSql("(getdate())");

            entity.HasOne(d => d.Room).WithMany(p => p.Orders).HasConstraintName("FK__Orders__RoomId__4CA06362");

            entity.HasOne(d => d.Shop).WithMany(p => p.Orders).HasConstraintName("FK__Orders__ShopId__4BAC3F29");
        });

        modelBuilder.Entity<OrderDetail>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__OrderDet__3214EC07CC7F871C");

            entity.HasOne(d => d.Order).WithMany(p => p.OrderDetails).HasConstraintName("FK__OrderDeta__Order__4D94879B");

            entity.HasOne(d => d.ProductVariant).WithMany(p => p.OrderDetails).HasConstraintName("FK__OrderDeta__Produ__4E88ABD4");
        });

        modelBuilder.Entity<Product>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Products__3214EC070E22A66A");
        });

        modelBuilder.Entity<ProductVariant>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__ProductV__3214EC07FA41E22A");

            entity.HasOne(d => d.Product).WithMany(p => p.ProductVariants).HasConstraintName("FK__ProductVa__Produ__4AB81AF0");
        });

        modelBuilder.Entity<Room>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Rooms__3214EC07BD475315");
        });

        modelBuilder.Entity<Shop>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Shops__3214EC07D24D509D");

            entity.HasOne(d => d.Room).WithMany(p => p.Shops).HasConstraintName("FK__Shops__RoomId__48CFD27E");
        });

        modelBuilder.Entity<User>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PK__Users__3214EC0745EB61AA");

            entity.HasOne(d => d.Room).WithMany(p => p.Users).HasConstraintName("FK__Users__RoomId__49C3F6B7");
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
