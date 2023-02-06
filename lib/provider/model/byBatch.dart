


class ByBatchModelProvider {
  int? id;
  String? batchNo;
  double? qty;
  double? remainingQty;

  ByBatchModelProvider({this.id, this.batchNo, this.qty,this.remainingQty});

  ByBatchModelProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchNo = json['batch_no'];
    qty = json['qty'];
    remainingQty = json ['remaining_qty'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batch_no'] = batchNo;
    data['qty'] = qty;
    data['remaining_qty']= remainingQty;

    return data;
  }
}
