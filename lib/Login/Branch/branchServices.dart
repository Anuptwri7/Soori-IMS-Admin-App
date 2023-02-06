import 'dart:convert';
import 'dart:developer';
import 'package:easycare/Login/Branch/model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant/ApiConstant.dart';

Future fetchBranchFromUrl() async {

  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  // log(sharedPreferences.getString("access_token"));
  final response = await http.get(
      Uri.parse(
          "${ApiConstant.baseUrl}branches"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        // 'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      }
  );
  // log("=============="+response.body);
  log(response.body.toString());
  List<Result> respond = [];

  final responseData = json.decode(response.body);
  responseData['results'].forEach(
        (element) {
      respond.add(
        Result.fromJson(element),
      );
    },
  );
  if (response.statusCode == 200) {
    return respond;
  }
}