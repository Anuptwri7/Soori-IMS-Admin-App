class StockAnalysisByLocationModel {
  StockAnalysisByLocationModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic? previous;
  List<Result>? results;

  factory StockAnalysisByLocationModel.fromJson(Map<String, dynamic> json) =>
      StockAnalysisByLocationModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.name,
    this.code,
    this.items,
    this.remainingQty,
  });

  int? id;
  String? name;
  String? code;
  List<Result>? items;
  int? remainingQty;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        name: json["name"],
        code: json["code"],
        items: json["items"] == null
            ? null
            : List<Result>.from(json["items"].map((x) => Result.fromJson(x))),
        remainingQty:
            json["remaining_qty"] == null ? null : json["remaining_qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "code": code,
        "items": items == null
            ? null
            : List<dynamic>.from(items!.map((x) => x.toJson())),
        "remaining_qty": remainingQty == null ? null : remainingQty,
      };
}
