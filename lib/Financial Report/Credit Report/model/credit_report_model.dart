class CreditReportModel {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? panVatNo;
  String? paidAmount;
  String? refundAmount;
  String? totalAmount;
  String? returnedAmount;
  String? createdByUserName;
  String? dueAmount;

  CreditReportModel(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.panVatNo,
      this.paidAmount,
      this.refundAmount,
      this.totalAmount,
      this.returnedAmount,
      this.createdByUserName,
      this.dueAmount});

  CreditReportModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    panVatNo = json['pan_vat_no'];
    paidAmount = json['paid_amount'];
    refundAmount = json['refund_amount'];
    totalAmount = json['total_amount'];
    returnedAmount = json['returned_amount'];
    createdByUserName = json['created_by_user_name'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['pan_vat_no'] = panVatNo;
    data['paid_amount'] = paidAmount;
    data['refund_amount'] = refundAmount;
    data['total_amount'] = totalAmount;
    data['returned_amount'] = returnedAmount;
    data['created_by_user_name'] = createdByUserName;
    data['due_amount'] = dueAmount;
    return data;
  }
}
