// To parse this JSON data, do
//
//     final customerModel = customerModelFromJson(jsonString);

import 'dart:convert';

CustomerModel customerModelFromJson(String str) =>
    CustomerModel.fromJson(json.decode(str));

String customerModelToJson(CustomerModel data) => json.encode(data.toJson());

class CustomerModel {
  CustomerModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  String? previous;
  List<AllCustomer>? results;

  factory CustomerModel.fromJson(Map<String, dynamic> json) => CustomerModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<AllCustomer>.from(json["results"].map((x) => AllCustomer.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class AllCustomer {
  AllCustomer({
    this.id,
    this.firstName,
    this.middleName,
    this.lastName,
    this.panVatNo,
  });

  int? id;
  String? firstName;
  String? middleName;
  String? lastName;
  String? panVatNo;

  factory AllCustomer.fromJson(Map<String, dynamic> json) => AllCustomer(
        id: json["id"],
        firstName: json["first_name"],
        middleName: json["middle_name"],
        lastName: json["last_name"],
        panVatNo: json["pan_vat_no"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "middle_name": middleName,
        "last_name": lastName,
        "pan_vat_no": panVatNo,
      };
}
