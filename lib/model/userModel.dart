class User {
  int? id;
  List<Groups>? groups;
  String? lastLogin;
  bool? isSuperuser;
  String? email;
  String? userName;
  String? firstName;
  String? middleName;
  String? lastName;
  String? fullName;
  String? createdDateAd;
  String? createdDateBs;
  bool? isStaff;
  bool? isActive;
  int? gender;
  String? birthDate;
  String? address;
  String? mobileNo;
  String? photo;
  int? createdBy;

  User(
      {this.id,
      this.groups,
      this.lastLogin,
      this.isSuperuser,
      this.email,
      this.userName,
      this.firstName,
      this.middleName,
      this.lastName,
      this.fullName,
      this.createdDateAd,
      this.createdDateBs,
      this.isStaff,
      this.isActive,
      this.gender,
      this.birthDate,
      this.address,
      this.mobileNo,
      this.photo,
      this.createdBy});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['groups'] != null) {
      groups = <Groups>[];
      json['groups'].forEach((v) {
        groups!.add(Groups.fromJson(v));
      });
    }
    lastLogin = json['last_login'];
    isSuperuser = json['is_superuser'];
    email = json['email'];
    userName = json['user_name'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    fullName = json['full_name'];
    createdDateAd = json['created_date_ad'];
    createdDateBs = json['created_date_bs'];
    isStaff = json['is_staff'];
    isActive = json['is_active'];
    gender = json['gender'];
    birthDate = json['birth_date'];
    address = json['address'];
    mobileNo = json['mobile_no'];
    photo = json['photo'];
    createdBy = json['created_by'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (groups != null) {
      data['groups'] = groups!.map((v) => v.toJson()).toList();
    }
    data['last_login'] = lastLogin;
    data['is_superuser'] = isSuperuser;
    data['email'] = email;
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['middle_name'] = middleName;
    data['last_name'] = lastName;
    data['full_name'] = fullName;
    data['created_date_ad'] = createdDateAd;
    data['created_date_bs'] = createdDateBs;
    data['is_staff'] = isStaff;
    data['is_active'] = isActive;
    data['gender'] = gender;
    data['birth_date'] = birthDate;
    data['address'] = address;
    data['mobile_no'] = mobileNo;
    data['photo'] = photo;
    data['created_by'] = createdBy;
    return data;
  }
}

class Groups {
  int? id;
  String? name;

  Groups({this.id, this.name});

  Groups.fromJson(Map<String, dynamic> json) {
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
