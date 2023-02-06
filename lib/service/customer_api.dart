import 'dart:convert';
import 'dart:developer';
import 'package:easycare/model/items_list.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Constant/apiConstant.dart';
import '../model/customer.dart';
import '../model/discount_list.dart';

class CustomerServices {
  //Customer Name

  List<Customer> allCustomer = <Customer>[];
  List<ItemModal> allItems = <ItemModal>[];

  Future fetchCustomerFromUrl() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${ApiConstant.customerList}'),
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
          allCustomer.add(Customer(
            id: json.decode(response.body)['results'][i]['id'].toString(),
            firstName: json
                .decode(response.body)['results'][i]['first_name']
                .toString(),
            middleName: json
                .decode(response.body)['results'][i]['middle_name']
                .toString(),
            lastName: json
                .decode(response.body)['results'][i]['last_name']
                .toString(),
          ));
        }
        // log(allSupplier.length.toString());
        return allCustomer;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchItemsFromUrl() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http
        .get(Uri.parse('https://$finalUrl/${ApiConstant.itemList}'), headers: {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
    });

    try {
      if (response.statusCode == 200) {
        final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
        int resultLength = json.decode(response.body)['results'].length;
        for (var i = 0; i < resultLength; i++) {
          sharedPreferences.setDouble("itemSaleCost",
          json.decode(response.body)['results'][i]['item_sale_cost']
          );

          allItems.add(ItemModal(
            id: json.decode(response.body)['results'][i]['id'],
            name: json.decode(response.body)['results'][i]['name'].toString(),
            remaining_qty: json
                .decode(response.body)['results'][i]['remaining_qty']
                .toString(),
            taxable: json.decode(response.body)['results'][i]['taxable'],
            tax_rate: json.decode(response.body)['results'][i]['tax_rate'],
            item_sale_cost: json.decode(response.body)['results'][i]['item_sale_cost'],

          ));
        }

        return allItems;
      }
    } catch (e) {
      throw Exception(e);
    }
  }


  Future fetchBatchFromUrl(int? itemId) async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${ApiConstant.byBatch + "&item=$itemId"}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });
    log("response body" + response.body);
    try {
      if (response.statusCode == 200) {
        var messageData = json.decode(response.body);

        return messageData;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  }
