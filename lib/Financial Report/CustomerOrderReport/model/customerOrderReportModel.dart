

class ResultsCustomer {
  int? id;
  String? customerFirstName;
  String? customerMiddleName;
  String? customerLastName;
  Null? discountSchemeName;
  String? createdByUserName;
  String? statusDisplay;
  String? createdDateAd;
  String? createdDateBs;
  int? deviceType;
  int? appType;
  String? orderNo;
  int? status;
  String? totalDiscount;
  String? totalTax;
  String? subTotal;
  String? totalDiscountableAmount;
  String? totalTaxableAmount;
  String? totalNonTaxableAmount;
  Null? deliveryDateAd;
  String? deliveryDateBs;
  String? deliveryLocation;
  String? grandTotal;
  bool? pickVerified;
  String? remarks;
  bool? byBatch;
  int? createdBy;
  int? customer;
  Null? discountScheme;

  ResultsCustomer(
      {this.id,
        this.customerFirstName,
        this.customerMiddleName,
        this.customerLastName,
        this.discountSchemeName,
        this.createdByUserName,
        this.statusDisplay,
        this.createdDateAd,
        this.createdDateBs,
        this.deviceType,
        this.appType,
        this.orderNo,
        this.status,
        this.totalDiscount,
        this.totalTax,
        this.subTotal,
        this.totalDiscountableAmount,
        this.totalTaxableAmount,
        this.totalNonTaxableAmount,
        this.deliveryDateAd,
        this.deliveryDateBs,
        this.deliveryLocation,
        this.grandTotal,
        this.pickVerified,
        this.remarks,
        this.byBatch,
        this.createdBy,
        this.customer,
        this.discountScheme});

  ResultsCustomer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customerFirstName = json['customer_first_name'];
    customerMiddleName = json['customer_middle_name'];
    customerLastName = json['customer_last_name'];
    discountSchemeName = json['discount_scheme_name'];
    createdByUserName = json['created_by_user_name'];
    statusDisplay = json['status_display'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    orderNo = json['order_no'];
    status = json['status'];
    totalDiscount = json['total_discount'];
    totalTax = json['total_tax'];
    subTotal = json['sub_total'];
    totalDiscountableAmount = json['total_discountable_amount'];
    totalTaxableAmount = json['total_taxable_amount'];
    totalNonTaxableAmount = json['total_non_taxable_amount'];
    deliveryDateAd = json['delivery_date_ad'];
    deliveryDateBs = json['delivery_date_bs'];
    deliveryLocation = json['delivery_location'];
    grandTotal = json['grand_total'];
    pickVerified = json['pick_verified'];
    remarks = json['remarks'];
    byBatch = json['by_batch'];
    createdBy = json['created_by'];
    customer = json['customer'];
    discountScheme = json['discount_scheme'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['customer_first_name'] = this.customerFirstName;
    data['customer_middle_name'] = this.customerMiddleName;
    data['customer_last_name'] = this.customerLastName;
    data['discount_scheme_name'] = this.discountSchemeName;
    data['created_by_user_name'] = this.createdByUserName;
    data['status_display'] = this.statusDisplay;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['device_type'] = this.deviceType;
    data['app_type'] = this.appType;
    data['order_no'] = this.orderNo;
    data['status'] = this.status;
    data['total_discount'] = this.totalDiscount;
    data['total_tax'] = this.totalTax;
    data['sub_total'] = this.subTotal;
    data['total_discountable_amount'] = this.totalDiscountableAmount;
    data['total_taxable_amount'] = this.totalTaxableAmount;
    data['total_non_taxable_amount'] = this.totalNonTaxableAmount;
    data['delivery_date_ad'] = this.deliveryDateAd;
    data['delivery_date_bs'] = this.deliveryDateBs;
    data['delivery_location'] = this.deliveryLocation;
    data['grand_total'] = this.grandTotal;
    data['pick_verified'] = this.pickVerified;
    data['remarks'] = this.remarks;
    data['by_batch'] = this.byBatch;
    data['created_by'] = this.createdBy;
    data['customer'] = this.customer;
    data['discount_scheme'] = this.discountScheme;
    return data;
  }
}