

class PartyReportPdf {
  int? id;
  String? name;
  String? panVatNo;
  String? paidAmount;
  String? refundAmount;
  String? totalAmount;
  String? returnedAmount;
  String? createdByUserName;
  String? dueAmount;

  PartyReportPdf(
      {this.id,
        this.name,
        this.panVatNo,
        this.paidAmount,
        this.refundAmount,
        this.totalAmount,
        this.returnedAmount,
        this.createdByUserName,
        this.dueAmount});

  PartyReportPdf.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    panVatNo = json['pan_vat_no'];
    paidAmount = json['paid_amount'];
    refundAmount = json['refund_amount'];
    totalAmount = json['total_amount'];
    returnedAmount = json['returned_amount'];
    createdByUserName = json['created_by_user_name'];
    dueAmount = json['due_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['pan_vat_no'] = this.panVatNo;
    data['paid_amount'] = this.paidAmount;
    data['refund_amount'] = this.refundAmount;
    data['total_amount'] = this.totalAmount;
    data['returned_amount'] = this.returnedAmount;
    data['created_by_user_name'] = this.createdByUserName;
    data['due_amount'] = this.dueAmount;
    return data;
  }
}
