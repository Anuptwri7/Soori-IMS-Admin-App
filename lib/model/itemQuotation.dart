

class ItemQuotation {
  ItemQuotation({
    this.id,
    this.itemCategory,
    this.manufacturer,
    this.genericName,
    this.unit,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.name,
    this.code,
    this.harmonicCode,
    this.itemType,
    this.stockAlertQty,
    this.location,
    this.basicInfo,
    this.taxable,
    this.taxRate,
    this.discountable,
    this.expirable,
    this.purchaseCost,
    this.saleCost,
    this.image,
    this.depreciationMethod,
    this.depreciationRate,
    this.depreciationYear,
    this.salvageValue,
    this.modelNo,
    this.fixedAsset,
    this.active,
    this.createdBy,
  });

  int? id;
  ItemCategory? itemCategory;
  Manufacturer? manufacturer;
  dynamic ?genericName;
  Unit? unit;
  DateTime? createdDateAd;
  DateTime ?createdDateBs;
  int ?deviceType;
  int ?appType;
  String? name;
  String ?code;
  String ?harmonicCode;
  int ?itemType;
  int? stockAlertQty;
  String? location;
  String ?basicInfo;
  bool ?taxable;
  String? taxRate;
  bool ?discountable;
  bool? expirable;
  String? purchaseCost;
  String? saleCost;
  String ?image;
  int ?depreciationMethod;
  String ?depreciationRate;
  String? depreciationYear;
  String ?salvageValue;
  String ?modelNo;
  bool ?fixedAsset;
  bool ?active;
  int ?createdBy;

  factory ItemQuotation.fromJson(Map<String, dynamic> json) => ItemQuotation(
    id: json["id"],
    itemCategory: ItemCategory.fromJson(json["item_category"]),
    manufacturer: Manufacturer.fromJson(json["manufacturer"]),
    genericName: json["generic_name"],
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
    createdDateAd: DateTime.parse(json["created_date_ad"]),
    createdDateBs: DateTime.parse(json["created_date_bs"]),
    deviceType: json["device_type"],
    appType: json["app_type"],
    name: json["name"],
    code: json["code"],
    harmonicCode: json["harmonic_code"],
    itemType: json["item_type"],
    stockAlertQty: json["stock_alert_qty"],
    location: json["location"],
    basicInfo: json["basic_info"],
    taxable: json["taxable"],
    taxRate: json["tax_rate"],
    discountable: json["discountable"],
    expirable: json["expirable"],
    purchaseCost: json["purchase_cost"],
    saleCost: json["sale_cost"],
    image: json["image"],
    depreciationMethod: json["depreciation_method"],
    depreciationRate: json["depreciation_rate"],
    depreciationYear: json["depreciation_year"],
    salvageValue: json["salvage_value"],
    modelNo: json["model_no"],
    fixedAsset: json["fixed_asset"],
    active: json["active"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "item_category": itemCategory!.toJson(),
    "manufacturer": manufacturer!.toJson(),
    "generic_name": genericName,
    "unit": unit == null ? null : unit!.toJson(),
    "created_date_ad": createdDateAd!.toIso8601String(),
    "created_date_bs": "${createdDateBs!.year.toString().padLeft(4, '0')}-${createdDateBs!.month.toString().padLeft(2, '0')}-${createdDateBs!.day.toString().padLeft(2, '0')}",
    "device_type": deviceType,
    "app_type": appType,
    "name": name,
    "code": code,
    "harmonic_code": harmonicCode,
    "item_type": itemType,
    "stock_alert_qty": stockAlertQty,
    "location": location,
    "basic_info": basicInfo,
    "taxable": taxable,
    "tax_rate": taxRate,
    "discountable": discountable,
    "expirable": expirable,
    "purchase_cost": purchaseCost,
    "sale_cost": saleCost,
    "image": image,
    "depreciation_method": depreciationMethod,
    "depreciation_rate": depreciationRate,
    "depreciation_year": depreciationYear,
    "salvage_value": salvageValue,
    "model_no": modelNo,
    "fixed_asset": fixedAsset,
    "active": active,
    "created_by": createdBy,
  };
}
class ItemCategory {
  ItemCategory({
    this.id,
    this.name,
    this.code,
  });
  int? id;
  ItemCategoryName? name;
  Code ?code;

  factory ItemCategory.fromJson(Map<String, dynamic> json) => ItemCategory(
    id: json["id"],
    name: itemCategoryNameValues.map![json["name"]],
    code: codeValues.map![json["code"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,

  };
}

enum Code { ITC_000001, ITC_000034, ITC_000004 }

final codeValues = EnumValues({
  "ITC-000001": Code.ITC_000001,
  "ITC-000004": Code.ITC_000004,
  "ITC-000034": Code.ITC_000034
});

enum ItemCategoryName { ELECTRONICS, BILL_ROLL, PEN_DISPLAY }

final itemCategoryNameValues = EnumValues({
  "BILL ROLL": ItemCategoryName.BILL_ROLL,
  "Electronics": ItemCategoryName.ELECTRONICS,
  "Pen display": ItemCategoryName.PEN_DISPLAY
});

class Manufacturer {
  Manufacturer({
    this.id,
    this.name,
  });

  int? id;
  ManufacturerName? name;

  factory Manufacturer.fromJson(Map<String, dynamic> json) => Manufacturer(
    id: json["id"],
    name: manufacturerNameValues.map![json["name"]],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": manufacturerNameValues.reverse![name],
  };
}

enum ManufacturerName { WACOM, XYZ }

final manufacturerNameValues = EnumValues({
  "Wacom": ManufacturerName.WACOM,
  "XYZ": ManufacturerName.XYZ
});

class Unit {
  Unit({
    this.id,
    this.name,
    this.shortForm,
  });

  int? id;
  String? name;
  String ?shortForm;

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    name: json["name"],
    shortForm: json["short_form"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "short_form": shortForm,
  };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String> ?reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
