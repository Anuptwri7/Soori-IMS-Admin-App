class CreditClearanceModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  CreditClearanceModel({this.count, this.next, this.previous, this.results});

  CreditClearanceModel.fromJson(Map<String, dynamic> json) {
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
  String? createdByUserName;
  String? saleNo;
  String? customerFirstName;
  String? customerLastName;
  String? paymentTypeDisplay;
  String? createdDateAd;
  String? createdDateBs;
  int? deviceType;
  int? appType;
  int? paymentType;
  String? receiptNo;
  String? totalAmount;
  String? remarks;
  int? createdBy;
  int? saleMaster;
  String? refCreditClearance;

  Results(
      {this.id,
      this.createdByUserName,
      this.saleNo,
      this.customerFirstName,
      this.customerLastName,
      this.paymentTypeDisplay,
      this.createdDateAd,
      this.createdDateBs,
      this.deviceType,
      this.appType,
      this.paymentType,
      this.receiptNo,
      this.totalAmount,
      this.remarks,
      this.createdBy,
      this.saleMaster,
      this.refCreditClearance});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdByUserName = json['created_by_user_name'];
    saleNo = json['sale_no'];
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    paymentTypeDisplay = json['payment_type_display'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    paymentType = json['payment_type'];
    receiptNo = json['receipt_no'];
    totalAmount = json['total_amount'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    saleMaster = json['sale_master'];
    refCreditClearance = json['ref_credit_clearance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_by_user_name'] = createdByUserName;
    data['sale_no'] = saleNo;
    data['customer_first_name'] = customerFirstName;
    data['customer_last_name'] = customerLastName;
    data['payment_type_display'] = paymentTypeDisplay;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['device_type'] = deviceType;
    data['app_type'] = appType;
    data['payment_type'] = paymentType;
    data['receipt_no'] = receiptNo;
    data['total_amount'] = totalAmount;
    data['remarks'] = remarks;
    data['created_by'] = createdBy;
    data['sale_master'] = saleMaster;
    data['ref_credit_clearance'] = refCreditClearance;
    return data;
  }
}
