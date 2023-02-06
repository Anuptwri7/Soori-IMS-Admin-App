class ItemsList {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  ItemsList({this.count, this.next, this.previous, this.results});

  ItemsList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    data['previous'] = previous;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
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
  double? itemSaleCost;

  Results(
      {this.id,
      this.purchaseCost,
      this.saleCost,
      this.name,
      this.discountable,
      this.taxable,
      this.taxRate,
      this.code,
      this.itemCategory,
      this.remainingQty,
      this.itemSaleCost});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    purchaseCost = json['purchase_cost'];
    saleCost = json['sale_cost'];
    name = json['name'];
    discountable = json['discountable'];
    taxable = json['taxable'];
    taxRate = json['tax_rate'];
    code = json['code'];
    itemCategory = json['item_category'];
    remainingQty = json['remaining_qty'];
    itemSaleCost = json['item_sale_cost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['purchase_cost'] = purchaseCost;
    data['sale_cost'] = saleCost;
    data['name'] = name;
    data['discountable'] = discountable;
    data['taxable'] = taxable;
    data['tax_rate'] = taxRate;
    data['code'] = code;
    data['item_category'] = itemCategory;
    data['remaining_qty'] = remainingQty;
    data['item_sale_cost'] = itemSaleCost;
    return data;
  }
}
