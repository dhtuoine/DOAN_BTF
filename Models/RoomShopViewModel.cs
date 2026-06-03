namespace DOAN_BTF.Models
{
    public class RoomShopViewModel
    {
        public List<Room> Rooms { get; set; } = new();

        public List<Shop> Shops { get; set; } = new();

        public int? SelectedRoomId { get; set; }
    }
}
