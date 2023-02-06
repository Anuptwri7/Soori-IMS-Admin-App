import 'dart:convert';

import 'package:easycare/model/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/apiConstant.dart';

Future fetchUserData() async {
  String id;
  List<User> data = <User>[];
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  id = sharedPreferences.get("userId").toString();
  final response = await http
      .get(Uri.parse('https://$finalUrl/${ApiConstant.user + id}'), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  });
  // log(response.body);
  try {
    if (response.statusCode == 200) {
      data.add(User(
          userName: json.decode(response.body)['user_name'].toString(),
          email: json.decode(response.body)['email'].toString(),
          mobileNo: json.decode(response.body)['mobile_no'].toString(),
          address: json.decode(response.body)['address'].toString(),
          photo: json.decode(response.body)['photo'].toString(),
          createdDateBs: json.decode(response.body)['created_date_bs'].toString(),
          gender: json.decode(response.body)['gender']));
          
      return data;
    }
  } catch (e) {
    throw Exception(e);
  }
  return null;
}
