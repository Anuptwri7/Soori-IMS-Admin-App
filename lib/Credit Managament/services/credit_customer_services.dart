import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constant/ApiConstant.dart';
import '../model/credit_customer_model.dart';
import '../model/get_credit_invoice_model.dart';

List<GetCreditInvoiceModel> allCustomer = <GetCreditInvoiceModel>[];

List<CreditClearanceCustomerModel> allCreditCustomer =
    <CreditClearanceCustomerModel>[];

Future fetchCreditCustomerFromUrl() async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.get(
      Uri.parse('https://$finalUrl/${ApiConstant.creditCustomer}' ),
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
        allCreditCustomer.add(
          CreditClearanceCustomerModel(
            id: json.decode(response.body)['results'][i]['id'],
            firstName: json
                .decode(response.body)['results'][i]['first_name']
                .toString(),
            creditAmount: json
                .decode(response.body)['results'][i]['credit_amount']
                .toString(),
            paidAmount: json
                .decode(response.body)['results'][i]['paid_amount']
                .toString(),
            dueAmount: json
                .decode(response.body)['results'][i]['due_amount']
                .toString(),
          ),
        );
      }
      return allCreditCustomer;
    }
  } catch (e) {
    throw Exception(e);
  }
}

Future getCreditInvoiceFromUrl(String customer) async {
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  final response = await http.get(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.getCreditInvoice + customer),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });

  try {
    if (response.statusCode == 200) {
      int resultLength = json.decode(response.body)['results'].length;
      for (var i = 0; i < resultLength; i++) {
        allCustomer.add(
          GetCreditInvoiceModel(
            customer: json.decode(response.body)['results'][i]['customer'],
            customerFirstName: json
                .decode(response.body)['results'][i]['customer_first_name']
                .toString(),
            saleNo:
                json.decode(response.body)['results'][i]['sale_no'].toString(),
            saleId: json.decode(response.body)['results'][i]['sale_id'],
            totalAmount: json
                .decode(response.body)['results'][i]['total_amount']
                .toString(),
            paidAmount: json
                .decode(response.body)['results'][i]['paid_amount']
                .toString(),
            dueAmount: json
                .decode(response.body)['results'][i]['due_amount']
                .toString(),
          ),
        );
      }
      return allCustomer;
    }
  } catch (e) {
    throw Exception(e);
  }
}
