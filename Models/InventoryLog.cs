using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class InventoryLog
{
    [Key]
    public int Id { get; set; }

    public int? ProductVariantId { get; set; }

    public int? Quantity { get; set; }

    public int? Type { get; set; }

    //[StringLength(500)]
    //public string? Note { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? CreateAt { get; set; }

    [ForeignKey("ProductVariantId")]
    [InverseProperty("InventoryLogs")]
    public virtual ProductVariant? ProductVariant { get; set; }
}
