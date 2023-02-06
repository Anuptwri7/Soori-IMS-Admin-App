class StockAnalysisModel {
  StockAnalysisModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
  int? count;
  String? next;
  dynamic? previous;
  List<Result>? results;
  factory StockAnalysisModel.fromJson(Map<String, dynamic> json) =>
      StockAnalysisModel(
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
    // this.purchaseCost,
    this.saleCost,
    this.name,
    this.discountable,
    this.taxable,
    this.taxRate,
    this.code,
    this.itemCategory,
    this.purchaseQty,
    this.purchaseReturnQty,
    this.saleQty,
    this.saleReturnQty,
    this.pendingCustomerOrderQty,
    this.chalanQty,
    this.chalanReturnQty,
    this.remainingQty,
  });
  int? id;
  // String? purchaseCost;
  double? saleCost;
  String? name;
  bool? discountable;
  bool? taxable;
  double? taxRate;
  String? code;
  int? itemCategory;
  double? purchaseQty;
  double? purchaseReturnQty;
  double? saleQty;
  double? saleReturnQty;
  double? pendingCustomerOrderQty;
  double? chalanQty;
  double? chalanReturnQty;
  double? remainingQty;
  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        // purchaseCost: json["purchase_cost"],
        saleCost: json["sale_cost"],
        name: json["name"],
        discountable: json["discountable"],
        taxable: json["taxable"],
        taxRate: json["tax_rate"],
        code: json["code"],
        itemCategory: json["item_category"],
        purchaseQty: json["purchase_qty"],
        purchaseReturnQty: json["purchase_return_qty"],
        saleQty: json["sale_qty"],
        saleReturnQty: json["sale_return_qty"],
        pendingCustomerOrderQty: json["pending_customer_order_qty"],
        chalanQty: json["chalan_qty"],
        chalanReturnQty: json["chalan_return_qty"],
        remainingQty: json["remaining_qty"],
      );
  Map<String, dynamic> toJson() => {
        "id": id,
        // "purchase_cost": purchaseCost,
        "sale_cost": saleCost,
        "name": name,
        "discountable": discountable,
        "taxable": taxable,
        "tax_rate": taxRate,
        "code": code,
        "item_category": itemCategory,
        "purchase_qty": purchaseQty,
        "purchase_return_qty": purchaseReturnQty,
        "sale_qty": saleQty,
        "sale_return_qty": saleReturnQty,
        "pending_customer_order_qty": pendingCustomerOrderQty,
        "chalan_qty": chalanQty,
        "chalan_return_qty": chalanReturnQty,
        "remaining_qty": remainingQty,
      };
}
