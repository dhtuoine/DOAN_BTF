using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class OrderDetail
{
    [Key]
    public int Id { get; set; } 

    public int? OrderId { get; set; }

    [StringLength(500)]
    public string? ProductLink { get; set; }

    public int? ProductVariantId { get; set; }

    public int? Quantity { get; set; }

    [Column(TypeName = "decimal(18, 2)")]
    public decimal? Price { get; set; }

    public bool? IsCustom { get; set; }

    [StringLength(500)]
    public string? Note { get; set; }

    [ForeignKey("OrderId")]
    [InverseProperty("OrderDetails")]
    public virtual Order? Order { get; set; }

    [ForeignKey("ProductVariantId")]
    [InverseProperty("OrderDetails")]
    public virtual ProductVariant? ProductVariant { get; set; }
}
