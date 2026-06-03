using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class Room
{
    [Key]
    public int Id { get; set; }

    [StringLength(100)]
    public string? RoomName { get; set; }

    [InverseProperty("Room")]
    public virtual ICollection<Order> Orders { get; set; } = new List<Order>();

    [InverseProperty("Room")]
    public virtual ICollection<Shop> Shops { get; set; } = new List<Shop>();

    [InverseProperty("Room")]
    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
