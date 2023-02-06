
import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/supplierListModel.dart';

class SupplierServices {
  //Customer Name

  List<supplierList> allSuppliers = <supplierList>[];


  Future fetchSupplierListFromUrl() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.supplierList),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

    log(response.body);

    try {
      if (response.statusCode == 200) {
        int resultLength = json.decode(response.body)['results'].length;
        for (var i = 0; i < resultLength; i++) {
          allSuppliers.add(supplierList(
            id: json.decode(response.body)['results'][i]['id'],
            name: json
                .decode(response.body)['results'][i]['name']
                .toString(),

          ));
        }
        // log(allSupplier.length.toString());
        return allSuppliers;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

