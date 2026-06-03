using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class Shop
{
    [Key]
    public int Id { get; set; }

    [StringLength(100)]
    public string? ShopName { get; set; }

    public int? RoomId { get; set; }

    [InverseProperty("Shop")]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    [ForeignKey("RoomId")]
    [InverseProperty("Shops")]
    public virtual Room? Room { get; set; }
}
