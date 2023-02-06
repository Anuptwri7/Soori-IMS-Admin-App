import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/Financial%20Report/Credit%20Report/model/credit_report_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

List<CreditReportModel> creditReport = <CreditReportModel>[];

Future fetchcreditReport(
    String customer, String user, String start, String end) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.get(
      Uri.parse('https://$finalUrl/'+
          ApiConstant.creditReport +
          "&id=$customer&created_by=$user&date_after=$start&date_before=$end"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });

  // log(response.body);
  log(response.body);

  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      for (var i = 0; i < resultLength; i++) {
        creditReport.add(
          CreditReportModel(
            id: json.decode(response.body)['results'][i]['id'],
            firstName: json
                .decode(response.body)['results'][i]['first_name']
                .toString(),
            middleName: json
                .decode(response.body)['results'][i]['middle_name']
                .toString(),
            lastName: json
                .decode(response.body)['results'][i]['last_name']
                .toString(),
            paidAmount: json
                .decode(response.body)['results'][i]['paid_amount']
                .toString(),
            totalAmount: json
                .decode(response.body)['results'][i]['total_amount']
                .toString(),
            dueAmount: json
                .decode(response.body)['results'][i]['due_amount']
                .toString(),
            refundAmount: json
                .decode(response.body)['results'][i]['refund_amount']
                .toString(),
            returnedAmount: json
                .decode(response.body)['results'][i]['returned_amount']
                .toString(),
            createdByUserName: json
                .decode(response.body)['results'][i]['created_by_user_name']
                .toString(),
          ),
        );
      }
      return creditReport;
    }
  } catch (e) {
    throw Exception(e);
  }
}
