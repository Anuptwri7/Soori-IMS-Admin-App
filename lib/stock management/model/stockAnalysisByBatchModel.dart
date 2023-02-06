class StockAnalysisByBatchModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  StockAnalysisByBatchModel(
      {this.count, this.next, this.previous, this.results});

  StockAnalysisByBatchModel.fromJson(Map<String, dynamic> json) {
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
  String? batchNo;
  int? purchaseQty;
  int? purchaseReturnQty;
  int? saleQty;
  int? saleReturnQty;
  int? customerOrderPendingQty;
  int? remainingQty;

  Results(
      {this.id,
      this.batchNo,
      this.purchaseQty,
      this.purchaseReturnQty,
      this.saleQty,
      this.saleReturnQty,
      this.customerOrderPendingQty,
      this.remainingQty});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    batchNo = json['batch_no'];
    purchaseQty = json['purchase_qty'];
    purchaseReturnQty = json['purchase_return_qty'];
    saleQty = json['sale_qty'];
    saleReturnQty = json['sale_return_qty'];
    customerOrderPendingQty = json['customer_order_pending_qty'];
    remainingQty = json['remaining_qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['batch_no'] = batchNo;
    data['purchase_qty'] = purchaseQty;
    data['purchase_return_qty'] = purchaseReturnQty;
    data['sale_qty'] = saleQty;
    data['sale_return_qty'] = saleReturnQty;
    data['customer_order_pending_qty'] = customerOrderPendingQty;
    data['remaining_qty'] = remainingQty;
    return data;
  }
}
