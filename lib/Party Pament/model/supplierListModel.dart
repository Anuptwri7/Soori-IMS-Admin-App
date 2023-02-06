class SupplierListModel {
  int? id;
  String? name;
  String? panVatNo;
  String? phoneNo;
  String? creditAmount;
  String? paidAmount;
  String? dueAmount;

  SupplierListModel(
      {this.id,
      this.name,
      this.panVatNo,
      this.phoneNo,
      this.creditAmount,
      this.paidAmount,
      this.dueAmount});

  SupplierListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    panVatNo = json['pan_vat_no'];
    phoneNo = json['phone_no'];
    creditAmount = json['credit_amount'];
    paidAmount = json['paid_amount'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['pan_vat_no'] = panVatNo;
    data['phone_no'] = phoneNo;
    data['credit_amount'] = creditAmount;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    return data;
  }
}
