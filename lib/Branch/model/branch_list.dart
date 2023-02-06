class Branch {
  // int? id;
  final String name;
  //String? address;
  // String ?subDomain;
  // bool ?active;

  Branch({
    // required this.id,
    required this.name,
    // required this.address,
    //  required this.subDomain,
    // required this.active
  });

  factory Branch.fromJson(Map<String, dynamic> json) {
    return Branch(
      // id: json['id'],
      name: json['name'],
      // address: json['address'],
      //  subDomain: json['subDomain'],
      // active: json['active'],
    );
  }
}
