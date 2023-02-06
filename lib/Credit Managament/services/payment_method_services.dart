import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constant/ApiConstant.dart';
import '../model/payment_model.dart';

List<PaymentMethodModel> paymentMethod = <PaymentMethodModel>[];

Future fetchPaymentFromUrl() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.get(
      Uri.parse('https://$finalUrl/${ApiConstant.paymentMethod}' ),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });

  // log(response.body);

  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      for (var i = 0; i < resultLength; i++) {
        paymentMethod.add(
          PaymentMethodModel(
            id: json.decode(response.body)['results'][i]['id'],
            name: json.decode(response.body)['results'][i]['name'].toString(),
            remarks:
                json.decode(response.body)['results'][i]['name'].toString(),
          ),
        );
      }
      return paymentMethod;

    }
  } catch (e) {
    throw Exception(e);
  }
}
