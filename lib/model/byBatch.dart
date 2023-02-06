
// class ByBatchModel {
//   ByBatchModel({
//     required this.count,
//     required this.next,
//     this.previous,
//     required this.results,
//   });
//
//   int count;
//   String next;
//   dynamic previous;
//   List<Result> results;
//
//   factory ByBatchModel.fromJson(Map<String, dynamic> json) => ByBatchModel(
//     count: json["count"],
//     next: json["next"],
//     previous: json["previous"],
//     results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "count": count,
//     "next": next,
//     "previous": previous,
//     "results": List<dynamic>.from(results.map((x) => x.toJson())),
//   };
// }

// class Result {
//   Result({
//     required this.id,
//     required this.batchNo,
//     required this.qty,
//     required this.remainingQty,
//   });
//
//   int id;
//   String batchNo;
//   int qty;
//   int remainingQty;
//
//   factory Result.fromJson(Map<String, dynamic> json) => Result(
//     id: json["id"],
//     batchNo: json["batch_no"],
//     qty: json["qty"],
//     remainingQty: json["remaining_qty"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "batch_no": batchNo,
//     "qty": qty,
//     "remaining_qty": remainingQty,
//   };
// }


class ByBatchModel {
  int? id;
  String? batchNo;
  double? qty;
  double? remainingQty;

  ByBatchModel({this.id, this.batchNo, this.qty,this.remainingQty});

  ByBatchModel.fromJson(Map<String, dynamic> json) {
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
