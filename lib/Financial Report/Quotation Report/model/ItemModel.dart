

class Result {
  Result({
    this.id,
    this.itemName,
    this.createdByUserName,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.qty,
    this.saleCost,
    this.remarks,
    this.cancelled,
    this.createdBy,
    this.quotation,
    this.item,
    this.itemCategory,
  });

  int? id;
  String? itemName;
  String ?createdByUserName;
  DateTime ?createdDateAd;
  DateTime? createdDateBs;
  int ?deviceType;
  int? appType;
  String? qty;
  String? saleCost;
  String ?remarks;
  bool ?cancelled;
  int? createdBy;
  int ?quotation;
  int? item;
  int ?itemCategory;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    itemName: json["item_name"],
    createdByUserName: json["created_by_user_name"],
    createdDateAd: DateTime.parse(json["created_date_ad"]),
    createdDateBs: DateTime.parse(json["created_date_bs"]),
    deviceType: json["device_type"],
    appType: json["app_type"],
    qty: json["qty"],
    saleCost: json["sale_cost"],
    remarks: json["remarks"],
    cancelled: json["cancelled"],
    createdBy: json["created_by"],
    quotation: json["quotation"],
    item: json["item"],
    itemCategory: json["item_category"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_name": itemName,
    "created_by_user_name": createdByUserName,
    "created_date_ad": createdDateAd?.toIso8601String(),
    "created_date_bs": "${createdDateBs?.year.toString().padLeft(4, '0')}-${createdDateBs?.month.toString().padLeft(2, '0')}-${createdDateBs?.day.toString().padLeft(2, '0')}",
    "device_type": deviceType,
    "app_type": appType,
    "qty": qty,
    "sale_cost": saleCost,
    "remarks": remarks,
    "cancelled": cancelled,
    "created_by": createdBy,
    "quotation": quotation,
    "item": item,
    "item_category": itemCategory,
  };
}
