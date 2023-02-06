class CreditClearanceCustomerModel {
  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? panVatNo;
  String? phoneNo;
  String? creditAmount;
  String? paidAmount;
  String? dueAmount;

  CreditClearanceCustomerModel(
      {this.id,
      this.firstName,
      this.middleName,
      this.lastName,
      this.panVatNo,
      this.phoneNo,
      this.creditAmount,
      this.paidAmount,
      this.dueAmount});

  CreditClearanceCustomerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    panVatNo = json['pan_vat_no'];
    phoneNo = json['phone_no'];
    creditAmount = json['credit_amount'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['pan_vat_no'] = panVatNo;
    data['phone_no'] = phoneNo;
    data['credit_amount'] = creditAmount;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    return data;
  }
}
