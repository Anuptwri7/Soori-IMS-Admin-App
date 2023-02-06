import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/model/byBatch.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/customer_order_list.dart';
import '../model/order_summary_list.dart';

List<ByBatchModel> finalList = <ByBatchModel>[];

class ListingServices {

  final player = AudioPlayer();

  void Notification() {
    player.play(AssetSource('images/notificationIMS.mp3'));
  }

  List<OrderSummaryList> allOrder = <OrderSummaryList>[];

  Future fetchOrderListFromUrl(String search) async {
    // CustomerList? custom erList;
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();
    final response = await http.get(
        Uri.parse('https://$finalUrl/${ApiConstant.orderMaster + search}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });
log(response.body);
    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        return <CustomerOrderList>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future fetchOrderSummaryListFromUrl(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${ApiConstant.orderSummary + id}'),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });
    log(response.body);

    try {
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log("${response.statusCode}");
        return <OrderSummaryList>[];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future cancelOrderFromUrl(String id) async {
    log("This is cancel order id :::$id");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.patch(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.cancelOrder + id),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode({"status": 3}));
    try {
      if (response.statusCode == 200) {
        Notification();
        return response.body;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future CancelSingleOrderFromUrl(String id) async {
    log("This is cancel single order id :::$id");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.patch(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.cancelSingleOrder + id),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode({"remarks": "Cancel", "cancelled": true}));
    log(response.statusCode.toString());
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        Notification();
        return response.body;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

class Batch {

  List<ByBatchModel> allBatch = <ByBatchModel>[];
  Future BatchFromUrl(String itemId) async {
    log("This is cancel single order id :::");
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final response = await http.get(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.byBatch + "&item=$itemId"),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      },
    );
log(response.body);
    try {
      if (response.statusCode == 200) {
        int resultLength = json.decode(response.body)['results'].length;
        for (var i = 0; i < resultLength; i++) {

          allBatch.add(ByBatchModel(
            id: json.decode(response.body)['results'][i]['id'],
            batchNo: json.decode(response.body)['results'][i]['batch_no'],
            qty: json.decode(response.body)['results'][i]['qty'],
            remainingQty: json.decode(response.body)['results'][i]
            ['remaining_qty'],
          ));


        }
        log("nkj"+ allBatch.toString());
        log("kjhjk"+finalList.toString());
        // return json.decode(response.body)['results'];
        return allBatch;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
