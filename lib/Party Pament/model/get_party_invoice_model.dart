

class GetPartyInvoiceModel {
  int? purchaseId;
  String? purchaseNumber;
  String? supplierName;
  String? createdByUserName;
  String? customerFirstName;
  String? customerMiddleName;
  String? customerLastName;
  String? totalAmount;
  String? paidAmount;
  String? dueAmount;
  String? purchaseNo;
  int? supplier;
  String? createdDateAd;
  String? createdDateBs;
  int? createdBy;
  String? remarks;

  GetPartyInvoiceModel(
      {this.purchaseId,
      this.purchaseNumber,
      this.supplierName,
      this.createdByUserName,
      this.customerFirstName,
      this.customerMiddleName,
      this.customerLastName,
      this.totalAmount,
      this.paidAmount,
      this.dueAmount,
      this.purchaseNo,
      this.supplier,
      this.createdDateAd,
      this.createdDateBs,
      this.createdBy,
      this.remarks});

  GetPartyInvoiceModel.fromJson(Map<String, dynamic> json) {
    purchaseId = json['purchase_id'];
    purchaseNumber = json['purchase_number'];
    supplierName = json['supplier_name'];
    createdByUserName = json['created_by_user_name'];
    customerFirstName = json['customer_first_name'];
    customerMiddleName = json['customer_middle_name'];
    customerLastName = json['customer_last_name'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
    purchaseNo = json['purchase_no'];
    supplier = json['supplier'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    createdBy = json['created_by'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['purchase_id'] = this.purchaseId;
    data['purchase_number'] = this.purchaseNumber;
    data['supplier_name'] = this.supplierName;
    data['created_by_user_name'] = this.createdByUserName;
    data['customer_first_name'] = this.customerFirstName;
    data['customer_middle_name'] = this.customerMiddleName;
    data['customer_last_name'] = this.customerLastName;
    data['total_amount'] = this.totalAmount;
    data['paid_amount'] = this.paidAmount;
    data['due_amount'] = this.dueAmount;
    data['purchase_no'] = this.purchaseNo;
    data['supplier'] = this.supplier;
    data['created_date_ad'] = this.createdDateAd;
    data['created_date_bs'] = this.createdDateBs;
    data['created_by'] = this.createdBy;
    data['remarks'] = this.remarks;
    return data;
  }
}
