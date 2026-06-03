using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using Microsoft.EntityFrameworkCore;

namespace DOAN_BTF.Models;

public partial class User
{
    [Key]
    public int Id { get; set; }

    [StringLength(100)]
    public string? Username { get; set; }

    [StringLength(100)]
    public string? Password { get; set; }

    public int? Role { get; set; }

    public int? RoomId { get; set; }

    [ForeignKey("RoomId")]
    [InverseProperty("Users")]
    public virtual Room? Room { get; set; }
}
