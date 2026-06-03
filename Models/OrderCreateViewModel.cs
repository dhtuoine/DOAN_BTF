namespace DOAN_BTF.Models
{
    public class OrderCreateViewModel
    {
        // ID
        public int Id { get; set; }

        // Order
        public string? OrderCode { get; set; }

        public string? CustomerName { get; set; }

        public string? PhoneNumber { get; set; }

        public string? Address { get; set; }

        public string? Country { get; set; }

        public int? ShopId { get; set; }

        public int? RoomId { get; set; }

        public string? Status { get; set; }

        // Custom
        public bool IsCustom { get; set; }

        // List áo
        public List<OrderDetail> OrderDetails { get; set; } = new();
    }
}