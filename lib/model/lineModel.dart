
import 'dart:convert';

LineModel lineChartFromJson(String str) => LineModel.fromJson(json.decode(str));

String lineChartToJson(LineModel data) => json.encode(data.toJson());

class LineModel {
  LineModel({
    required this.date,
    required this.purchaseAmount,
    required this.saleAmount,
  });

  List<int> date;
  List<double> purchaseAmount;
  List<double> saleAmount;

  factory LineModel.fromJson(Map<String, dynamic> json) => LineModel(
    date: List<int>.from(json["date"].map((x) => x)),
    purchaseAmount: List<double>.from(json["purchase_amount"].map((x) => x.toDouble())),
    saleAmount: List<double>.from(json["sale_amount"].map((x) => x.toDouble())),
  );

  Map<String, dynamic> toJson() => {
    "date": List<dynamic>.from(date.map((x) => x)),
    "purchase_amount": List<dynamic>.from(purchaseAmount.map((x) => x)),
    "sale_amount": List<dynamic>.from(saleAmount.map((x) => x)),
  };
}


