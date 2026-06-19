using ExcelDataReader;
using Microsoft.ML;
using System.Data;
using System.Globalization;
using System.Linq;
namespace DOAN_BTF.Services.ML
{
    public class MlTrainingService
    {
        private readonly IWebHostEnvironment _env;

        public MlTrainingService(IWebHostEnvironment env)
        {
            _env = env;
            System.Text.Encoding.RegisterProvider(System.Text.CodePagesEncodingProvider.Instance);
        }

        public string TrainProductVariantModel()
        {
            var filePath = Path.Combine(_env.WebRootPath, "ml", "dulieuBTF.xlsx");
            var modelPath = Path.Combine(_env.WebRootPath, "ml", "demand_level_model.zip");

            var data = ReadExcel(filePath).ToList();

            var mlContext = new MLContext(seed: 1);
            var trainData = mlContext.Data.LoadFromEnumerable(data);
            var split = mlContext.Data.TrainTestSplit(trainData, testFraction: 0.2);

            var pipeline =
                mlContext.Transforms.Conversion.MapValueToKey(
                    outputColumnName: "Label",
                    inputColumnName: nameof(AiTrainingData.DemandLevel))

                .Append(mlContext.Transforms.Categorical.OneHotEncoding("MonthEncoded", nameof(AiTrainingData.Month)))
                .Append(mlContext.Transforms.Categorical.OneHotEncoding("WeekEncoded", nameof(AiTrainingData.WeekOfYear)))
                .Append(mlContext.Transforms.Categorical.OneHotEncoding("SeasonEncoded", nameof(AiTrainingData.Season)))
                .Append(mlContext.Transforms.Categorical.OneHotEncoding("CountryEncoded", nameof(AiTrainingData.Country)))
                .Append(mlContext.Transforms.Categorical.OneHotEncoding("ProductTypeEncoded", nameof(AiTrainingData.ProductType)))
                .Append(mlContext.Transforms.Categorical.OneHotEncoding("ColorEncoded", nameof(AiTrainingData.Color)))
                

                .Append(mlContext.Transforms.Concatenate(
                    "Features",
                    "MonthEncoded",
                    "WeekEncoded",
                    "SeasonEncoded",
                    "CountryEncoded",
                    "ProductTypeEncoded",
                    "ColorEncoded"))
                

                .Append(mlContext.MulticlassClassification.Trainers.OneVersusAll(
                    mlContext.BinaryClassification.Trainers.FastForest(
                        labelColumnName: "Label",
                        featureColumnName: "Features",
                        numberOfTrees: 100,
                        numberOfLeaves: 20,
                        minimumExampleCountPerLeaf: 5)))

                .Append(mlContext.Transforms.Conversion.MapKeyToValue(
                    outputColumnName: nameof(AiPrediction.PredictedLabel),
                    inputColumnName: "PredictedLabel"));

            var model = pipeline.Fit(split.TrainSet);
            var predictions = model.Transform(split.TestSet);
            var metrics = mlContext.MulticlassClassification.Evaluate(predictions);

            mlContext.Model.Save(model, trainData.Schema, modelPath);

            return $"Train xong FastForest. Số dòng: {data.Count} - MicroAccuracy: {metrics.MicroAccuracy:P2} - MacroAccuracy: {metrics.MacroAccuracy:P2}";
        }

        private List<AiTrainingData> ReadExcel(string filePath)
        {
            var result = new List<AiTrainingData>();

            using var stream = File.Open(filePath, FileMode.Open, FileAccess.Read);
            using var reader = ExcelReaderFactory.CreateReader(stream);

            var dataSet = reader.AsDataSet(new ExcelDataSetConfiguration
            {
                ConfigureDataTable = _ => new ExcelDataTableConfiguration
                {
                    UseHeaderRow = true
                }
            });

            var table = dataSet.Tables["ViviEmbroidery"];

            if (table == null)
            {
                return result;
            }

            foreach (DataRow row in table.Rows)
            {
                var item = new AiTrainingData
                {
                    Month = NormalizeText(GetValue(row, "Month")),
                    WeekOfYear = NormalizeText(GetValue(row, "WeekOfYear")),
                    Season = NormalizeText(GetValue(row, "Season")),
                    Country = NormalizeTitleCase(GetValue(row, "Country")),
                    ProductType = NormalizeProductType(GetValue(row, "ProductType")),
                    Color = NormalizeTitleCase(GetValue(row, "Color", "Màu")),
                    SizeClean = NormalizeText(GetValue(row, "SizeClean")),
                    DemandLevel = NormalizeText(GetValue(row, "DemandLevel"))
                };

                if (!string.IsNullOrWhiteSpace(item.Month)
                    && !string.IsNullOrWhiteSpace(item.WeekOfYear)
                    && !string.IsNullOrWhiteSpace(item.Season)
                    && !string.IsNullOrWhiteSpace(item.Country)
                    && !string.IsNullOrWhiteSpace(item.ProductType)
                    && !string.IsNullOrWhiteSpace(item.Color)
                    && !string.IsNullOrWhiteSpace(item.SizeClean)
                    && !string.IsNullOrWhiteSpace(item.DemandLevel))
                {
                    result.Add(item);
                }
            }

            return result;
        }

        private string GetValue(DataRow row, params string[] columnNames)
        {
            foreach (var name in columnNames)
            {
                if (row.Table.Columns.Contains(name))
                    return row[name]?.ToString()?.Trim() ?? "";
            }

            return "";
        }

        private string NormalizeText(string value)
        {
            return value?.Trim() ?? "";
        }

        private string NormalizeTitleCase(string value)
        {
            if (string.IsNullOrWhiteSpace(value))
                return "";

            value = value.Trim().ToLower();

            if (value == "coffe")
                value = "coffee";

            return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(value);
        }

        private string NormalizeProductType(string value)
        {
            value = value?.Trim().ToLower() ?? "";

            if (value.Contains("bodysuit"))
                return "Bodysuit";

            if (value.Contains("long"))
                return "Romper Longer";

            if (value.Contains("short"))
                return "Romper Short";

            return "";
        }
    }
}