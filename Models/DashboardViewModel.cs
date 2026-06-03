using System.Collections.Generic;

namespace DOAN_BTF.Models
{
    public class DashboardViewModel
    {
        public int RunningOrdersCount { get; set; }
        public int LowStockCount { get; set; }
        public int ReadyToShipCount { get; set; }

        public List<Order>? ActiveOrders { get; set; }
        public List<Order>? RecentOrders { get; set; }
        public List<Inventory>? LowInventories { get; set; }
    }
}