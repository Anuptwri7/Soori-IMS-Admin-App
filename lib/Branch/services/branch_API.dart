import 'dart:convert';

import "package:http/http.dart" as http;

import '../../Constant/ApiConstant.dart';

class BranchServices {
  Future fetchBranchApiFromUrl() async {
    final response = await http.get(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.branch),
    );
    List<String> respond = [];
    respond.add('Select Branch');
    for (var i = 0; i < json.decode(response.body).length; i++) {
      respond.add("${json.decode(response.body)[i]['name']}");
    }
    if (response.statusCode == 200) {
      return respond;
    }
  }
}
