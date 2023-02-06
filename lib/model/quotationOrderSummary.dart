import 'dart:convert';

QuotationOrderSummeryModel quotationOrderSummeryModelFromJson(String str) =>
    QuotationOrderSummeryModel.fromJson(json.decode(str));

String quotationOrderSummeryModelToJson(QuotationOrderSummeryModel data) =>
    json.encode(data.toJson());

class QuotationOrderSummeryModel {
  QuotationOrderSummeryModel({
    this.id,
    this.customer,
    this.createdByUserName,
    this.quotationDetails,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.quotationNo,
    this.deliveryDateAd,
    this.deliveryDateBs,
    this.deliveryLocation,
    this.remarks,
    this.cancelled,
    this.createdBy,
  });

  int? id;
  Customer? customer;
  String? createdByUserName;
  List<QuotationDetail>? quotationDetails;
  DateTime? createdDateAd;
  DateTime? createdDateBs;
  int? deviceType;
  int? appType;
  String? quotationNo;
  dynamic? deliveryDateAd;
  String? deliveryDateBs;
  String? deliveryLocation;
  String? remarks;
  bool? cancelled;
  int? createdBy;

  factory QuotationOrderSummeryModel.fromJson(Map<String, dynamic> json) =>
      QuotationOrderSummeryModel(
        id: json["id"],
        customer: Customer.fromJson(json["customer"]),
        createdByUserName: json["created_by_user_name"],
        quotationDetails: List<QuotationDetail>.from(
            json["quotation_details"].map((x) => QuotationDetail.fromJson(x))),
        createdDateAd: DateTime.parse(json["created_date_ad"]),
        createdDateBs: DateTime.parse(json["created_date_bs"]),
        deviceType: json["device_type"],
        appType: json["app_type"],
        quotationNo: json["quotation_no"],
        deliveryDateAd: json["delivery_date_ad"],
        deliveryDateBs: json["delivery_date_bs"],
        deliveryLocation: json["delivery_location"],
        remarks: json["remarks"],
        cancelled: json["cancelled"],
        createdBy: json["created_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer": customer!.toJson(),
        "created_by_user_name": createdByUserName,
        "quotation_details":
            List<dynamic>.from(quotationDetails!.map((x) => x.toJson())),
        "created_date_ad": createdDateAd!.toIso8601String(),
        "created_date_bs":
            "${createdDateBs!.year.toString().padLeft(4, '0')}-${createdDateBs!.month.toString().padLeft(2, '0')}-${createdDateBs!.day.toString().padLeft(2, '0')}",
        "device_type": deviceType,
        "app_type": appType,
        "quotation_no": quotationNo,
        "delivery_date_ad": deliveryDateAd,
        "delivery_date_bs": deliveryDateBs,
        "delivery_location": deliveryLocation,
        "remarks": remarks,
        "cancelled": cancelled,
        "created_by": createdBy,
      };
}

class Customer {
  Customer({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.address,
  });

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        address: json["address"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "address": address,
      };
}

class QuotationDetail {
  QuotationDetail({
    this.id,
    this.item,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.qty,
    this.saleCost,
    this.remarks,
    this.cancelled,
    this.createdBy,
    this.itemCategory,
  });

  int? id;
  Item? item;
  DateTime? createdDateAd;
  DateTime? createdDateBs;
  int? deviceType;
  int? appType;
  String? qty;
  String? saleCost;
  String? remarks;
  bool? cancelled;
  int? createdBy;
  int? itemCategory;

  factory QuotationDetail.fromJson(Map<String, dynamic> json) =>
      QuotationDetail(
        id: json["id"],
        item: Item.fromJson(json["item"]),
        createdDateAd: DateTime.parse(json["created_date_ad"]),
        createdDateBs: DateTime.parse(json["created_date_bs"]),
        deviceType: json["device_type"],
        appType: json["app_type"],
        qty: json["qty"],
        saleCost: json["sale_cost"],
        remarks: json["remarks"],
        cancelled: json["cancelled"],
        createdBy: json["created_by"],
        itemCategory: json["item_category"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "item": item!.toJson(),
        "created_date_ad": createdDateAd!.toIso8601String(),
        "created_date_bs":
            "${createdDateBs!.year.toString().padLeft(4, '0')}-${createdDateBs!.month.toString().padLeft(2, '0')}-${createdDateBs!.day.toString().padLeft(2, '0')}",
        "device_type": deviceType,
        "app_type": appType,
        "qty": qty,
        "sale_cost": saleCost,
        "remarks": remarks,
        "cancelled": cancelled,
        "created_by": createdBy,
        "item_category": itemCategory,
      };
}

class Item {
  Item({
    this.id,
    // this.createdDateAd,
    // this.createdDateBs,
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
    this.itemCategory,
    this.manufacturer,
    this.genericName,
    this.unit,
  });

  int? id;

  // DateTime? createdDateAd;
  // DateTime ?createdDateBs;
  int? deviceType;
  int? appType;
  String? name;
  String? code;
  String? harmonicCode;
  int? itemType;
  int? stockAlertQty;
  String? location;
  String? basicInfo;
  bool? taxable;
  String? taxRate;
  bool? discountable;
  bool? expirable;
  String? purchaseCost;
  String? saleCost;
  dynamic image;
  int? depreciationMethod;
  String? depreciationRate;
  String? depreciationYear;
  String? salvageValue;
  String? modelNo;
  bool? fixedAsset;
  bool? active;
  int? createdBy;
  int? itemCategory;
  int? manufacturer;
  dynamic? genericName;
  int? unit;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        id: json["id"],
        // createdDateAd: DateTime.parse(json["created_date_ad"]),
        // createdDateBs: DateTime.parse(json["created_date_bs"]),
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
        itemCategory: json["item_category"],
        manufacturer: json["manufacturer"],
        genericName: json["generic_name"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        // "created_date_ad": createdDateAd!.toIso8601String(),
        // "created_date_bs": "${createdDateBs!.year.toString().padLeft(4, '0')}-${createdDateBs!.month.toString().padLeft(2, '0')}-${createdDateBs!.day.toString().padLeft(2, '0')}",
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
        "item_category": itemCategory,
        "manufacturer": manufacturer,
        "generic_name": genericName,
        "unit": unit,
      };
}
