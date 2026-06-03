using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

[Table("Inventory")]
public partial class Inventory
{
    [Key]
    public int Id { get; set; }

    public int? ProductVariantId { get; set; }

    public int? Quantity { get; set; }


    [ForeignKey("ProductVariantId")]
    [InverseProperty("Inventories")]
    public virtual ProductVariant? ProductVariant { get; set; }
}
