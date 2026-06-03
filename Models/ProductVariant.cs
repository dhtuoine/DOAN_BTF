using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class ProductVariant
{
    [Key]
    public int Id { get; set; }

    public int? ProductId { get; set; }

    [StringLength(50)]
    public string? Color { get; set; }

    //[StringLength(100)]
    //public string? SKU { get; set; }

    [StringLength(50)]
    public string? Size { get; set; }

    [InverseProperty("ProductVariant")]
    public virtual ICollection<Inventory> Inventories { get; set; } = new List<Inventory>();

    [InverseProperty("ProductVariant")]
    public virtual ICollection<InventoryLog> InventoryLogs { get; set; } = new List<InventoryLog>();

    [InverseProperty("ProductVariant")]
    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    [ForeignKey("ProductId")]
    [InverseProperty("ProductVariants")]
    public virtual Product? Product { get; set; }
}
