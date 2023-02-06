class UserList {
  int? id;
  String? userName;
  String? firstName;
  String? lastName;

  UserList({this.id, this.userName, this.firstName, this.lastName});

  UserList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name'];
    firstName = json['first_name'];
    lastName = json['last_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = userName;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    return data;
  }
}
