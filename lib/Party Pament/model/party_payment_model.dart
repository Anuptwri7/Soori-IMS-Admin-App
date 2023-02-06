class PartyPaymentModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  PartyPaymentModel({this.count, this.next, this.previous, this.results});

  PartyPaymentModel.fromJson(Map<String, dynamic> json) {
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
  String? paymentTypeDisplay;
  String? purchaseNo;
  String? supplierName;
  String? createdDateAd;
  String? createdDateBs;
  int? deviceType;
  int? appType;
  int? paymentType;
  String? receiptNo;
  String? totalAmount;
  String? remarks;
  int? createdBy;
  int? purchaseMaster;
  String? refPartyClearance;

  Results(
      {this.id,
      this.createdByUserName,
      this.paymentTypeDisplay,
      this.purchaseNo,
      this.supplierName,
      this.createdDateAd,
      this.createdDateBs,
      this.deviceType,
      this.appType,
      this.paymentType,
      this.receiptNo,
      this.totalAmount,
      this.remarks,
      this.createdBy,
      this.purchaseMaster,
      this.refPartyClearance});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdByUserName = json['created_by_user_name'];
    paymentTypeDisplay = json['payment_type_display'];
    purchaseNo = json['purchase_no'];
    supplierName = json['supplier_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    paymentType = json['payment_type'];
    receiptNo = json['receipt_no'];
    totalAmount = json['total_amount'];
    remarks = json['remarks'];
    createdBy = json['created_by'];
    purchaseMaster = json['purchase_master'];
    refPartyClearance = json['ref_party_clearance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_by_user_name'] = createdByUserName;
    data['payment_type_display'] = paymentTypeDisplay;
    data['purchase_no'] = purchaseNo;
    data['supplier_name'] = supplierName;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['device_type'] = deviceType;
    data['app_type'] = appType;
    data['payment_type'] = paymentType;
    data['receipt_no'] = receiptNo;
    data['total_amount'] = totalAmount;
    data['remarks'] = remarks;
    data['created_by'] = createdBy;
    data['purchase_master'] = purchaseMaster;
    data['ref_party_clearance'] = refPartyClearance;
    return data;
  }
}
