

import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/Financial%20Report/CustomerOrderReport/customerOrderReportUi.dart';
import 'package:easycare/Financial%20Report/CustomerOrderReport/model/customerOrderReportModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;



//Customer Name

List<ResultsCustomer> customerOrderReport = <ResultsCustomer>[];

Future fetchCustomerOrderPdfFromUrl(
   String user, String type
    ) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  final response = await http.get(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.customerOrderReport + "&created_by=$user&date_after=${StartdateController.text}&date_before=${EnddateController.text}&status=$type"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });
  log("kjh"+user);
  log(response.body);
  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      for (var i = 0; i < resultLength; i++) {
        customerOrderReport.add(ResultsCustomer(
          id: json.decode(response.body)['results'][i]['id'],
          createdByUserName: json.decode(response.body)['results'][i]['created_by_user_name'],
          orderNo: json.decode(response.body)['results'][i]['order_no'],
          customerFirstName: json.decode(response.body)['results'][i]['customer_first_name'],
          customerLastName: json.decode(response.body)['results'][i]['customer_last_name'],
          subTotal: json.decode(response.body)['results'][i]['sub_total'],
          grandTotal: json.decode(response.body)['results'][i]['grand_total'],
          statusDisplay: json.decode(response.body)['results'][i]['status_display']
        ));

      }
      // customerOrderReport.clear();

      // log(allSupplier.length.toString());
      return customerOrderReport;
    }
  } catch (e) {
    throw Exception(e);
  }
}


