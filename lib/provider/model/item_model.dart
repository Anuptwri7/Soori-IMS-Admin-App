// To parse this JSON data, do
//
//     final itemListModel = itemListModelFromJson(jsonString);

import 'dart:convert';

ItemListModel itemListModelFromJson(String str) =>
    ItemListModel.fromJson(json.decode(str));

String itemListModelToJson(ItemListModel data) => json.encode(data.toJson());

class ItemListModel {
  ItemListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<ItemModel>? results;

  factory ItemListModel.fromJson(Map<String, dynamic> json) => ItemListModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<ItemModel>.from(
            json["results"].map((x) => ItemModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class ItemModel {
  ItemModel({
    this.id,
    this.purchaseCost,
    this.saleCost,
    this.name,
    this.discountable,
    this.taxable,
    this.taxRate,
    this.code,
    this.itemCategory,
    this.remainingQty,
  });

  int? id;
  double? purchaseCost;
  double? saleCost;
  String? name;
  bool? discountable;
  bool? taxable;
  double? taxRate;
  String? code;
  int? itemCategory;
  double? remainingQty;

  factory ItemModel.fromJson(Map<String, dynamic> json) => ItemModel(
        id: json["id"],
        purchaseCost: json["purchase_cost"],
        saleCost: json["sale_cost"],
        name: json["name"],
        discountable: json["discountable"],
        taxable: json["taxable"],
        taxRate: json["tax_rate"],
        code: json["code"],
        itemCategory: json["item_category"],
        remainingQty: json["remaining_qty"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "purchase_cost": purchaseCost,
        "sale_cost": saleCost,
        "name": name,
        "discountable": discountable,
        "taxable": taxable,
        "tax_rate": taxRate,
        "code": code,
        "item_category": itemCategory,
        "remaining_qty": remainingQty,
      };
}
