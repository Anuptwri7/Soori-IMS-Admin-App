import 'dart:convert';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/user_list_model.dart';

//Customer Name

List<UserList> allUser = <UserList>[];

Future fetchUserListFromUrl() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http
      .get(Uri.parse('https://$finalUrl/${ApiConstant.userList}'), headers: {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  });

  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      for (var i = 0; i < resultLength; i++) {
        allUser.add(UserList(
          id: json.decode(response.body)['results'][i]['id'],
          firstName:
              json.decode(response.body)['results'][i]['first_name'].toString(),
          userName:
              json.decode(response.body)['results'][i]['user_name'].toString(),
          lastName:
              json.decode(response.body)['results'][i]['last_name'].toString(),
        ));
      }
      return allUser;
    }
  } catch (e) {
    throw Exception(e);
  }
}
