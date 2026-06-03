using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class Order
{
    [Key]
    public int Id { get; set; }

    [StringLength(100)]
    public string? OrderCode { get; set; }

    [Column(TypeName = "datetime")]
    public DateTime? CreateAt { get; set; }

    [StringLength(200)]
    public string? CustomerName { get; set; }

    [StringLength(50)]
    public string? PhoneNumber { get; set; }

    [StringLength(300)]
    public string? Address { get; set; }

    [StringLength(100)]
    public string? Country { get; set; }

    public int? ShopId { get; set; }

    public int? RoomId { get; set; }

    [StringLength(50)]
    public string? Status { get; set; }

    [InverseProperty("Order")]
    public virtual ICollection<OrderDetail> OrderDetails { get; set; } = new List<OrderDetail>();

    [ForeignKey("RoomId")]
    [InverseProperty("Orders")]
    public virtual Room? Room { get; set; }

    [ForeignKey("ShopId")]
    [InverseProperty("Orders")]
    public virtual Shop? Shop { get; set; }
}
