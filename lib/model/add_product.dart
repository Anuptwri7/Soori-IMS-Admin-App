class AddProductModel {
  int? status;
  int? customer;
  int? subTotal;
  int? totalDiscount;
  int? totalTax;
  int? grandTotal;
  String? remarks;
  List<OrderDetails>? orderDetails;
  int? totalDiscountableAmount;
  int? totalTaxableAmount;
  int? totalNonTaxableAmount;
  int? discountScheme;
  int? discountRate;
  String? deliveryLocation;
  int? deliveryDateAd;

  AddProductModel(
      {this.status,
      this.customer,
      this.subTotal,
      this.totalDiscount,
      this.totalTax,
      this.grandTotal,
      this.remarks,
      this.orderDetails,
      this.totalDiscountableAmount,
      this.totalTaxableAmount,
      this.totalNonTaxableAmount,
      this.discountScheme,
      this.discountRate,
      this.deliveryLocation,
      this.deliveryDateAd});

  AddProductModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customer = json['customer'];
    subTotal = json['sub_total'];
    totalDiscount = json['total_discount'];
    totalTax = json['total_tax'];
    grandTotal = json['grand_total'];
    remarks = json['remarks'];
    if (json['order_details'] != null) {
      orderDetails = <OrderDetails>[];
      json['order_details'].forEach((v) {
        orderDetails!.add(OrderDetails.fromJson(v));
      });
    }
    totalDiscountableAmount = json['total_discountable_amount'];
    totalTaxableAmount = json['total_taxable_amount'];
    totalNonTaxableAmount = json['total_non_taxable_amount'];
    discountScheme = json['discount_scheme'];
    discountRate = json['discount_rate'];
    deliveryLocation = json['delivery_location'];
    deliveryDateAd = json['delivery_date_ad'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['customer'] = customer;
    data['sub_total'] = subTotal;
    data['total_discount'] = totalDiscount;
    data['total_tax'] = totalTax;
    data['grand_total'] = grandTotal;
    data['remarks'] = remarks;
    if (orderDetails != null) {
      data['order_details'] = orderDetails!.map((v) => v.toJson()).toList();
    }
    data['total_discountable_amount'] = totalDiscountableAmount;
    data['total_taxable_amount'] = totalTaxableAmount;
    data['total_non_taxable_amount'] = totalNonTaxableAmount;
    data['discount_scheme'] = discountScheme;
    data['discount_rate'] = discountRate;
    data['delivery_location'] = deliveryLocation;
    data['delivery_date_ad'] = deliveryDateAd;
    return data;
  }
}

class OrderDetails {
  int? item;
  int? itemCategory;
  bool? taxable;
  bool? discountable;
  int? qty;
  int? purchaseCost;
  String? saleCost;
  String? discountRate;
  int? discountAmount;
  int? taxRate;
  int? taxAmount;
  int? grossAmount;
  int? netAmount;
  String? remarks;
  bool? isNew;
  String? unique;
  bool? cancelled;

  OrderDetails(
      {this.item,
      this.itemCategory,
      this.taxable,
      this.discountable,
      this.qty,
      this.purchaseCost,
      this.saleCost,
      this.discountRate,
      this.discountAmount,
      this.taxRate,
      this.taxAmount,
      this.grossAmount,
      this.netAmount,
      this.remarks,
      this.isNew,
      this.unique,
      this.cancelled});

  OrderDetails.fromJson(Map<String, dynamic> json) {
    item = json['item'];
    itemCategory = json['item_category'];
    taxable = json['taxable'];
    discountable = json['discountable'];
    qty = json['qty'];
    purchaseCost = json['purchase_cost'];
    saleCost = json['sale_cost'];
    discountRate = json['discount_rate'];
    discountAmount = json['discount_amount'];
    taxRate = json['tax_rate'];
    taxAmount = json['tax_amount'];
    grossAmount = json['gross_amount'];
    netAmount = json['net_amount'];
    remarks = json['remarks'];
    isNew = json['isNew'];
    unique = json['unique'];
    cancelled = json['cancelled'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item'] = item;
    data['item_category'] = itemCategory;
    data['taxable'] = taxable;
    data['discountable'] = discountable;
    data['qty'] = qty;
    data['purchase_cost'] = purchaseCost;
    data['sale_cost'] = saleCost;
    data['discount_rate'] = discountRate;
    data['discount_amount'] = discountAmount;
    data['tax_rate'] = taxRate;
    data['tax_amount'] = taxAmount;
    data['gross_amount'] = grossAmount;
    data['net_amount'] = netAmount;
    data['remarks'] = remarks;
    data['isNew'] = isNew;
    data['unique'] = unique;
    data['cancelled'] = cancelled;
    return data;
  }
}
