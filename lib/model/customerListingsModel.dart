class CustomerListingModel {
  int? count;
  String? next;
  String? previous;
  List<Results>? results;

  CustomerListingModel({this.count, this.next, this.previous, this.results});

  CustomerListingModel.fromJson(Map<String, dynamic> json) {
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
  String? countryName;
  String? createdDateAd;
  String? createdDateBs;
  int? deviceType;
  int? appType;
  String? firstName;
  String? middleName;
  String? lastName;
  String? address;
  String? phoneNo;
  String? mobileNo;
  String? emailId;
  String? panVatNo;
  int? taxRegSystem;
  String? image;
  bool? active;
  int? createdBy;
  Country? country;

  Results(
      {this.id,
      this.countryName,
      this.createdDateAd,
      this.createdDateBs,
      this.deviceType,
      this.appType,
      this.firstName,
      this.middleName,
      this.lastName,
      this.address,
      this.phoneNo,
      this.mobileNo,
      this.emailId,
      this.panVatNo,
      this.taxRegSystem,
      this.image,
      this.active,
      this.createdBy,
      this.country});

  Results.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    countryName = json['country_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    deviceType = json['device_type'];
    appType = json['app_type'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    address = json['address'];
    phoneNo = json['phone_no'];
    mobileNo = json['mobile_no'];
    emailId = json['email_id'];
    panVatNo = json['pan_vat_no'];
    taxRegSystem = json['tax_reg_system'];
    image = json['image'];
    active = json['active'];
    createdBy = json['created_by'];
    country =
        json['country'] != null ? Country.fromJson(json['country']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['country_name'] = countryName;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['device_type'] = deviceType;
    data['app_type'] = appType;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['address'] = address;
    data['phone_no'] = phoneNo;
    data['mobile_no'] = mobileNo;
    data['email_id'] = emailId;
    data['pan_vat_no'] = panVatNo;
    data['tax_reg_system'] = taxRegSystem;
    data['image'] = image;
    data['active'] = active;
    data['created_by'] = createdBy;
    if (country != null) {
      data['country'] = country!.toJson();
    }
    return data;
  }
}

class Country {
  int? id;
  String? name;

  Country({this.id, this.name});

  Country.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
