class OrderSummaryList {
  int? id;
  List<OrderDetails>? orderDetails;
  String? orderNo;
  String? createdByUserName;
  String? statusDisplay;
  Customer? customer;
  String? totalDiscount;
  DiscountScheme? discountScheme;
  int? status;
  String? totalTax;
  String? subTotal;
  String? deliveryDateAd;
  String? deliveryDateBs;
  String? deliveryLocation;
  String? grandTotal;
  String? remarks;
  String? createdDateAd;
  String? createdDateBs;
  bool? byBatch;

  OrderSummaryList(
      {this.id,
        this.orderDetails,
        this.orderNo,
        this.createdByUserName,
        this.statusDisplay,
        this.customer,
        this.totalDiscount,
        this.discountScheme,
        this.status,
        this.totalTax,
        this.subTotal,
        this.deliveryDateAd,
        this.deliveryDateBs,
        this.deliveryLocation,
        this.grandTotal,
        this.remarks,
        this.createdDateAd,
        this.createdDateBs,
      this.byBatch
      });

  OrderSummaryList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    orderNo = json['order_no'];
    createdByUserName = json['created_by_user_name'];
    statusDisplay = json['status_display'];
    customer =
    json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    totalDiscount = json['total_discount'];
    discountScheme = json['discount_scheme'] != null
        ? DiscountScheme.fromJson(json['discount_scheme'])
        : null;
    status = json['status'];
    totalTax = json['total_tax'];
    subTotal = json['sub_total'];
    deliveryDateAd = json['delivery_date_ad'];
    deliveryDateBs = json['delivery_date_bs'];
    deliveryLocation = json['delivery_location'];
    grandTotal = json['grand_total'];
    remarks = json['remarks'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    byBatch= json['by_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    data['order_no'] = orderNo;
    data['created_by_user_name'] = createdByUserName;
    data['status_display'] = statusDisplay;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['total_discount'] = totalDiscount;
    if (discountScheme != null) {
      data['discount_scheme'] = discountScheme!.toJson();
    }
    data['status'] = status;
    data['total_tax'] = totalTax;
    data['sub_total'] = subTotal;
    data['delivery_date_ad'] = deliveryDateAd;
    data['delivery_date_bs'] = deliveryDateBs;
    data['delivery_location'] = deliveryLocation;
    data['grand_total'] = grandTotal;
    data['remarks'] = remarks;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['by_batch'] = byBatch;
    return data;
  }
}

class OrderDetails {
  int? id;
  List<CustomerPackingTypes>? customerPackingTypes;
  Item? item;
  String? createdDateAd;
  String? createdDateBs;
  int? deviceType;
  int? appType;
  String? qty;
  String? purchaseCost;
  String? saleCost;
  bool? discountable;
  bool? taxable;
  String? taxRate;
  String? taxAmount;
  String? discountRate;
  String? discountAmount;
  String? grossAmount;
  String? netAmount;
  bool? cancelled;
  bool? picked;
  String? remarks;
  int? createdBy;
  int? itemCategory;
  int? purchaseDetail;

  OrderDetails(
      {this.id,
        this.customerPackingTypes,
        this.item,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.qty,
        this.purchaseCost,
        this.saleCost,
        this.discountable,
        this.taxable,
        this.taxRate,
        this.taxAmount,
        this.discountRate,
        this.discountAmount,
        this.grossAmount,
        this.netAmount,
        this.cancelled,
        this.picked,
        this.remarks,
        this.createdBy,
        this.itemCategory,
        this.purchaseDetail});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // id = int.parse(json['id']);

    if (json['customer_packing_types'] != null) {
      customerPackingTypes = <CustomerPackingTypes>[];
      json['customer_packing_types'].forEach((v) {
        customerPackingTypes!.add(CustomerPackingTypes.fromJson(v));
      });
    }
    item = json['item'] != null ? Item.fromJson(json['item']) : null;
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    qty = json['qty'];
    purchaseCost = json['purchase_cost'];
    saleCost = json['sale_cost'];
    discountable = json['discountable'];
    taxable = json['taxable'];
    taxRate = json['tax_rate'];
    taxAmount = json['tax_amount'];
    discountRate = json['discount_rate'];
    discountAmount = json['discount_amount'];
    grossAmount = json['gross_amount'];
    netAmount = json['net_amount'];
    cancelled = json['cancelled'];
    picked = json['picked'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    itemCategory = json['item_category'];
    purchaseDetail = json['purchase_detail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (customerPackingTypes != null) {
      data['customer_packing_types'] =
          customerPackingTypes!.map((v) => v.toJson()).toList();
    }
    if (item != null) {
      data['item'] = item!.toJson();
    }
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['device_type'] = deviceType;
    data['app_type'] = appType;
    data['qty'] = qty;
    data['purchase_cost'] = purchaseCost;
    data['sale_cost'] = saleCost;
    data['discountable'] = discountable;
    data['taxable'] = taxable;
    data['tax_rate'] = taxRate;
    data['tax_amount'] = taxAmount;
    data['discount_rate'] = discountRate;
    data['discount_amount'] = discountAmount;
    data['gross_amount'] = grossAmount;
    data['net_amount'] = netAmount;
    data['cancelled'] = cancelled;
    data['picked'] = picked;
    data['remarks'] = remarks;
    data['created_by'] = createdBy;
    data['item_category'] = itemCategory;
    data['purchase_detail'] = purchaseDetail;
    return data;
  }
}

class CustomerPackingTypes {
  int? id;
  String? locationCode;
  int? location;
  String? code;
  int? saleDetail;
  int? packingTypeCode;
  List<SalePackingTypeDetailCode>? salePackingTypeDetailCode;

  CustomerPackingTypes(
      {this.id,
        this.locationCode,
        this.location,
        this.code,
        this.saleDetail,
        this.packingTypeCode,
        this.salePackingTypeDetailCode});

  CustomerPackingTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    locationCode = json['location_code'];
    location = json['location'];
    code = json['code'];
    saleDetail = json['sale_detail'];
    packingTypeCode = json['packing_type_code'];
    if (json['sale_packing_type_detail_code'] != null) {
      salePackingTypeDetailCode = <SalePackingTypeDetailCode>[];
      json['sale_packing_type_detail_code'].forEach((v) {
        salePackingTypeDetailCode!.add(SalePackingTypeDetailCode.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['location_code'] = locationCode;
    data['location'] = location;
    data['code'] = code;
    data['sale_detail'] = saleDetail;
    data['packing_type_code'] = packingTypeCode;
    if (salePackingTypeDetailCode != null) {
      data['sale_packing_type_detail_code'] =
          salePackingTypeDetailCode!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalePackingTypeDetailCode {
  int? id;
  int? packingTypeDetailCode;
  String? code;

  SalePackingTypeDetailCode({this.id, this.packingTypeDetailCode, this.code});

  SalePackingTypeDetailCode.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    packingTypeDetailCode = json['packing_type_detail_code'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['packing_type_detail_code'] = packingTypeDetailCode;
    data['code'] = code;
    return data;
  }
}

class Item {
  int? id;
  String? name;
  String? code;

  Item({this.id, this.name, this.code});

  Item.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    code = json['code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['code'] = code;
    return data;
  }
}

class Customer {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;

  Customer({this.id, this.firstName, this.middleName, this.lastName});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    return data;
  }
}

class DiscountScheme {
  int? id;
  String? name;
  String? rate;

  DiscountScheme({this.id, this.name, this.rate});

  DiscountScheme.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rate = json['rate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['rate'] = rate;
    return data;
  }
}