
import 'dart:convert';
import 'dart:developer';
import 'package:easycare/Constant/apiConstant.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'model/ItemModel.dart';
List<Result> quotationReport = <Result>[];

Future fetchQuotationPdfFromUrl(
    String id
    ) async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  final response = await http.get(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.viewQuotation + id + '&cancelled=false'),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });


  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      log(":::::::::::::::::"+resultLength.toString());
      for (var i = 0; i <  json.decode(response.body)['results'].length; i++) {
        quotationReport.add(Result(
          id: json.decode(response.body)['results'][i]['id'],
          itemName: json.decode(response.body)['results'][i]['item_name'],
            saleCost: json.decode(response.body)['results'][i]['sale_cost'],
          qty:  json.decode(response.body)['results'][i]['qty'],
          cancelled:  json.decode(response.body)['results'][i]['cancelled'],

        )
                );
        // log("kjhsk:::::::::::::"+quotationReport[i].id.toString());
      }
      log(quotationReport.toString());
      return quotationReport;

    }
  } catch (e) {
    throw Exception(e);
  }
}


