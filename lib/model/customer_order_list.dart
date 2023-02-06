// class CustomerOrderList {
//   int? count;
//   String? next;
//   String? previous;
//   List<Results>? results;

//   CustomerOrderList({this.count, this.next, this.previous, this.results});

//   CustomerOrderList.fromJson(Map<String, dynamic> json) {
//     count = json['count'];
//     next = json['next'];
//     previous = json['previous'];
//     if (json['results'] != null) {
//       results = <Results>[];
//       json['results'].forEach((v) {
//         results!.add(Results.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['count'] = count;
//     data['next'] = next;
//     data['previous'] = previous;
//     if (results != null) {
//       data['results'] = results!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Results {
//   int? id;
//   String? orderNo;
//   Customer? customer;
//   String? customerFirstName;
//   String? customerLastName;
//   bool? pickVerified;
//   String? createdByUserName;
//   String? statusDisplay;
//   String? totalDiscount;
//   int? status;
//   String? totalTax;
//   String? subTotal;
//   String? deliveryDateAd;
//   String? deliveryDateBs;
//   String? deliveryLocation;
//   String? grandTotal;
//   bool? isPicked;
//   String? remarks;
//   String? createdDateAd;
//   String? createdDateBs;

//   Results(
//       {this.id,
//       this.orderNo,
//       this.customer,
//       this.customerFirstName,
//       this.customerLastName,
//       this.pickVerified,
//       this.createdByUserName,
//       this.statusDisplay,
//       this.totalDiscount,
//       this.status,
//       this.totalTax,
//       this.subTotal,
//       this.deliveryDateAd,
//       this.deliveryDateBs,
//       this.deliveryLocation,
//       this.grandTotal,
//       this.isPicked,
//       this.remarks,
//       this.createdDateAd,
//       this.createdDateBs});

//   Results.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     orderNo = json['order_no'];
//     customer =
//         json['customer'] != null ? Customer.fromJson(json['customer']) : null;
//     customerFirstName = json['customer_first_name'];
//     customerLastName = json['customer_last_name'];
//     pickVerified = json['pick_verified'];
//     createdByUserName = json['created_by_user_name'];
//     statusDisplay = json['status_display'];
//     totalDiscount = json['total_discount'];
//     status = json['status'];
//     totalTax = json['total_tax'];
//     subTotal = json['sub_total'];
//     deliveryDateAd = json['delivery_date_ad'];
//     deliveryDateBs = json['delivery_date_bs'];
//     deliveryLocation = json['delivery_location'];
//     grandTotal = json['grand_total'];
//     isPicked = json['is_picked'];
//     remarks = json['remarks'];
//     createdDateAd = json['created_date_ad'];
//     createdDateBs = json['created_date_bs'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['order_no'] = orderNo;
//     if (customer != null) {
//       data['customer'] = customer!.toJson();
//     }
//     data['customer_first_name'] = customerFirstName;
//     data['customer_last_name'] = customerLastName;
//     data['pick_verified'] = pickVerified;
//     data['created_by_user_name'] = createdByUserName;
//     data['status_display'] = statusDisplay;
//     data['total_discount'] = totalDiscount;
//     data['status'] = status;
//     data['total_tax'] = totalTax;
//     data['sub_total'] = subTotal;
//     data['delivery_date_ad'] = deliveryDateAd;
//     data['delivery_date_bs'] = deliveryDateBs;
//     data['delivery_location'] = deliveryLocation;
//     data['grand_total'] = grandTotal;
//     data['is_picked'] = isPicked;
//     data['remarks'] = remarks;
//     data['created_date_ad'] = createdDateAd;
//     data['created_date_bs'] = createdDateBs;
//     return data;
//   }
// }

// class Customer {
//   String? firstName;
//   String? lastName;
//   int? id;

//   Customer({this.firstName, this.lastName, this.id});

//   Customer.fromJson(Map<String, dynamic> json) {
//     firstName = json['first_name'];
//     lastName = json['last_name'];
//     id = json['id'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['first_name'] = firstName;
//     data['last_name'] = lastName;
//     data['id'] = id;
//     return data;
//   }
// }

//Live
class CustomerOrderList {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  CustomerOrderList({this.count, this.next, this.previous, this.results});

  CustomerOrderList.fromJson(Map<String, dynamic> json) {
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
  String? orderNo;
  Customer? customer;
  String? customerFirstName;
  String? customerLastName;
  bool? pickVerified;
  String? createdByUserName;
  String? statusDisplay;
  String? totalDiscount;
  int? status;
  String? totalTax;
  String? subTotal;
  String? deliveryDateAd;
  String? deliveryDateBs;
  String? deliveryLocation;
  String? grandTotal;
  bool? isPicked;
  String? remarks;
  String? createdDateAd;
  String? createdDateBs;
  bool? byBatch;

  Results(
      {this.id,
      this.orderNo,
      this.customer,
      this.customerFirstName,
      this.customerLastName,
      this.pickVerified,
      this.createdByUserName,
      this.statusDisplay,
      this.totalDiscount,
      this.status,
      this.totalTax,
      this.subTotal,
      this.deliveryDateAd,
      this.deliveryDateBs,
      this.deliveryLocation,
      this.grandTotal,
      this.isPicked,
      this.remarks,
      this.createdDateAd,
      this.createdDateBs,
      this.byBatch});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderNo = json['order_no'];
    customer =
        json['customer'] != null ? Customer.fromJson(json['customer']) : null;
    customerFirstName = json['customer_first_name'];
    customerLastName = json['customer_last_name'];
    pickVerified = json['pick_verified'];
    createdByUserName = json['created_by_user_name'];
    statusDisplay = json['status_display'];
    totalDiscount = json['total_discount'];
    status = json['status'];
    totalTax = json['total_tax'];
    subTotal = json['sub_total'];
    deliveryDateAd = json['delivery_date_ad'];
    deliveryDateBs = json['delivery_date_bs'];
    deliveryLocation = json['delivery_location'];
    grandTotal = json['grand_total'];
    isPicked = json['is_picked'];
    remarks = json['remarks'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    byBatch = json['by_batch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['order_no'] = orderNo;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    data['customer_first_name'] = customerFirstName;
    data['customer_last_name'] = customerLastName;
    data['pick_verified'] = pickVerified;
    data['created_by_user_name'] = createdByUserName;
    data['status_display'] = statusDisplay;
    data['total_discount'] = totalDiscount;
    data['status'] = status;
    data['total_tax'] = totalTax;
    data['sub_total'] = subTotal;
    data['delivery_date_ad'] = deliveryDateAd;
    data['delivery_date_bs'] = deliveryDateBs;
    data['delivery_location'] = deliveryLocation;
    data['grand_total'] = grandTotal;
    data['is_picked'] = isPicked;
    data['remarks'] = remarks;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['by_batch'] = byBatch;
    return data;
  }
}

class Customer {
  String? firstName;
  String? lastName;
  int? id;

  Customer({this.firstName, this.lastName, this.id});

  Customer.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['id'] = id;
    return data;
  }
}
