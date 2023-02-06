class PaymentMethodModel {
  int? id;
  String? name;
  String? remarks;

  PaymentMethodModel({this.id, this.name, this.remarks});

  PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    remarks = json['remarks'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['remarks'] = remarks;
    return data;
  }
}
