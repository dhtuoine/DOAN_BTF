namespace DOAN_BTF.Models
{
    public class OrderStatusConst
    {
        public const string Chuacoao = "Chưa có áo";
        public const string ChoTheu = "Chờ thêu";
        public const string DangTheu = "Đang thêu";
        public const string HoanThanh = "Hoàn thành";
        public const string Huy = "Hủy";
        public const string Tracking = "Đã AddTracking";


        public static List<string> All = new()
    {
        Chuacoao,
        ChoTheu,
        DangTheu,
        HoanThanh,
        Huy,
        Tracking

    };
    }
}
