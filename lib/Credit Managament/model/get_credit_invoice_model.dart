class GetCreditInvoiceModel {
  int? saleId;
  String? saleNo;
  int? customer;
  String? customerFirstName;
  String? customerMiddleName;
  String? customerLastName;
  String? totalAmount;
  String? paidAmount;
  String? dueAmount;
  String? createdDateAd;
  String? createdDateBs;
  int? createdBy;
  String? createdByUserName;
  String? remarks;

  GetCreditInvoiceModel(
      {this.saleId,
      this.saleNo,
      this.customer,
      this.customerFirstName,
      this.customerMiddleName,
      this.customerLastName,
      this.totalAmount,
      this.paidAmount,
      this.dueAmount,
      this.createdDateAd,
      this.createdDateBs,
      this.createdBy,
      this.createdByUserName,
      this.remarks});

  GetCreditInvoiceModel.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    saleNo = json['sale_no'];
    customer = json['customer'];
    customerFirstName = json['customer_first_name'];
    customerMiddleName = json['customer_middle_name'];
    customerLastName = json['customer_last_name'];
    totalAmount = json['total_amount'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    createdBy = json['created_by'];
    createdByUserName = json['created_by_user_name'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['sale_id'] = saleId;
    data['sale_no'] = saleNo;
    data['customer'] = customer;
    data['customer_first_name'] = customerFirstName;
    data['customer_middle_name'] = customerMiddleName;
    data['customer_last_name'] = customerLastName;
    data['total_amount'] = totalAmount;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['created_by'] = createdBy;
    data['created_by_user_name'] = createdByUserName;
    data['remarks'] = remarks;
    return data;
  }
}
