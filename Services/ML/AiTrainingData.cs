namespace DOAN_BTF.Services.ML
{
    public class AiTrainingData
    {
        public string Month { get; set; } = "";
        public string WeekOfYear { get; set; } = "";
        public string Season { get; set; } = "";
        public string Country { get; set; } = "";

        public string ProductType { get; set; } = "";
        public string Color { get; set; } = "";
        public string SizeClean { get; set; } = "";

        // Label cần dự đoán: mức nhu cầu sản xuất
        public string DemandLevel { get; set; } = "";
    }

    public class AiPrediction
    {
        public string PredictedLabel { get; set; } = "";
        public float[] Score { get; set; } = [];
    }
}