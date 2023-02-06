
import 'dart:convert';

Quotation quotationFromJson(String str) => Quotation.fromJson(json.decode(str));

String quotationToJson(Quotation data) => json.encode(data.toJson());

class Quotation {
  Quotation({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  int count;
  dynamic next;
  dynamic previous;
  List<Result> results;

  factory Quotation.fromJson(Map<String, dynamic> json) => Quotation(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.customerFirstName,
    this.customerLastName,
    this.createdByUserName,
    this.customer,
    this.createdDateAd,
    this.createdDateBs,
    this.deviceType,
    this.appType,
    this.quotationNo,
    this.deliveryDateAd,
    this.deliveryDateBs,
    this.deliveryLocation,
    this.remarks,
    this.cancelled,
    this.createdBy,
  });

  int? id;
  String? customerFirstName;
  String? customerLastName;
  String ?createdByUserName;
  Customer? customer;
  DateTime ?createdDateAd;
  DateTime ?createdDateBs;
  int ?deviceType;
  int ?appType;
  String? quotationNo;
  dynamic? deliveryDateAd;
  String ?deliveryDateBs;
  String ?deliveryLocation;
  String ?remarks;
  bool ?cancelled;
  int ?createdBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    customerFirstName: json["customer_first_name"],
    customerLastName: json["customer_last_name"],
    createdByUserName: json["created_by_user_name"],
    customer: Customer.fromJson(json["customer"]),
    createdDateAd: DateTime.parse(json["created_date_ad"]),
    createdDateBs: DateTime.parse(json["created_date_bs"]),
    deviceType: json["device_type"],
    appType: json["app_type"],
    quotationNo: json["quotation_no"],
    deliveryDateAd: json["delivery_date_ad"],
    deliveryDateBs: json["delivery_date_bs"],
    deliveryLocation: json["delivery_location"],
    remarks: json["remarks"],
    cancelled: json["cancelled"],
    createdBy: json["created_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "customer_first_name": customerFirstName,
    "customer_last_name": customerLastName,
    "created_by_user_name": createdByUserName,
    "customer": customer?.toJson(),
    "created_date_ad": createdDateAd?.toIso8601String(),
    "created_date_bs": "${createdDateBs?.year.toString().padLeft(4, '0')}-${createdDateBs?.month.toString().padLeft(2, '0')}-${createdDateBs?.day.toString().padLeft(2, '0')}",
    "device_type": deviceType,
    "app_type": appType,
    "quotation_no": quotationNo,
    "delivery_date_ad": deliveryDateAd,
    "delivery_date_bs": deliveryDateBs,
    "delivery_location": deliveryLocation,
    "remarks": remarks,
    "cancelled": cancelled,
    "created_by": createdBy,
  };
}

class Customer {
  Customer({
    required this.firstName,
    required this.lastName,
    required this.id,
  });

  String firstName;
  String lastName;
  int id;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
    firstName: json["first_name"],
    lastName: json["last_name"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "id": id,
  };
}
