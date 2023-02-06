

import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/Financial%20Report/Party%20Report/Services/reportApi.dart';


import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../model/partyReportModel.dart';
import '../partyReportScreen.dart';


  //Customer Name

  List<PartyReportPdf> partyReport = <PartyReportPdf>[];

  Future fetchPdfFromUrl(
      String supplier, String user
      ) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.partyReport + "&id=$supplier&created_by=$user&date_after=${StartdateController.text}&date_before=${EnddateController.text}"),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

log("kjh"+user);

    try {
      if (response.statusCode == 200) {
        int resultLength = json.decode(response.body)['results'].length;
        for (var i = 0; i < resultLength; i++) {
          partyReport.add(PartyReportPdf(
            id: json.decode(response.body)['results'][i]['id'],
            name: json
                .decode(response.body)['results'][i]['name']
                .toString(),
            paidAmount: json.decode(response.body)['results'][i]['paid_amount'].toString(),
            panVatNo: json.decode(response.body)['results'][i]['pan_vat_no'].toString(),
            returnedAmount: json.decode(response.body)['results'][i]['returned_amount'].toString(),
            refundAmount: json.decode(response.body)['results'][i]['refund_amount'].toString(),
            createdByUserName: json.decode(response.body)['results'][i]['created_by_user_name'].toString(),
            totalAmount: json.decode(response.body)['results'][i]['total_amount'].toString(),
            dueAmount: json.decode(response.body)['results'][i]['due_amount'].toString(),

          ));
        }

        // log(allSupplier.length.toString());
        return partyReport;
      }
    } catch (e) {
      throw Exception(e);
    }
  }


