import 'dart:convert';
import 'dart:developer';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../Constant/apiConstant.dart';

class CustomerServices {
  //Customer Name

  static Future fetchCustomerFromUrl() async {
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
    try {
      if (response.statusCode == 200) {
        var messageData = json.decode(response.body);
        return messageData;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  static Future fetchItemsFromUrl() async {
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
      log(response.body);

        var messageData = json.decode(response.body);
        return messageData;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
 static Future fetchBatchFromUrl(int? itemId) async {
    log(itemId.toString());
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final response = await http.get(
        Uri.parse('https://$finalUrl/${ApiConstant.byBatch + "&item=$itemId"}' ),
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

  // fetchPaginatedCustomer(
  //     String url, SharedPreferences sharedPreferences) async {
  //   final response = await http.get(Uri.parse(url), headers: {
  //     'Content-type': 'application/json',
  //     'Accept': 'application/json',
  //     'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  //   });
  //   if (response.statusCode == 200) {
  //     int resultLength = json.decode(response.body)['results'].length;
  //     for (var i = 0; i < resultLength; i++) {
  //       allCustomer.add(Customer(
  //         id: json.decode(response.body)['results'][i]['id'].toString(),
  //         firstName:
  //             json.decode(response.body)['results'][i]['first_name'].toString(),
  //         middleName: json
  //             .decode(response.body)['results'][i]['middle_name']
  //             .toString(),
  //         lastName:
  //             json.decode(response.body)['results'][i]['last_name'].toString(),
  //       ));
  //       // allCustomer.add(
  //       //     json.decode(response.body)['results'][i]['first_name'].toString());
  //     }
  //     // log("Recurring" + allCustomer.length.toString());
  //     if (resultLength >= 10) {
  //       String nextUrl = json.decode(response.body)['next'];
  //       await fetchPaginatedCustomer(nextUrl, sharedPreferences);
  //     }
  //   }
  // }

  // Future fetchCustomerFromUrl(
  //     {String url = ApiConstant.baseUrl + ApiConstant.customerList}) async {
  //   try {
  //     final SharedPreferences sharedPreferences =
  //         await SharedPreferences.getInstance();
  //     await fetchPaginatedCustomer(url, sharedPreferences);
  //     log("API customer log");

  //     return allCustomer;
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  //Discount
  // Future fetchDiscountFromUrl() async {
  //   final SharedPreferences sharedPreferences =
  //       await SharedPreferences.getInstance();
  //   final response = await http.get(
  //       Uri.parse(
  //           "https://api-soori-ims-staging.dipendranath.com.np/api/v1/purchase-app/discount-scheme-list"),
  //       headers: {
  //         'Content-type': 'application/json',
  //         'Accept': 'application/json',
  //         'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
  //       });
  //   // log("customer List ${json.decode(response.body)['results']}");
  //   // log("${response.statusCode}");
  //   try {
  //     if (response.statusCode == 200) {
  //       return response.body;
  //     } else {
  //       // log("${response.statusCode}");
  //       return <Discount>[];
  //     }
  //   } catch (e) {
  //     throw Exception(e);
  //   }
  // }

  //Items List
//   fetchPaginatedItem(String url1, SharedPreferences sharedPreferences) async {
//     final response = await http.get(Uri.parse(url1), headers: {
//       'Content-type': 'application/json',
//       'Accept': 'application/json',
//       'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
//     });
//     if (response.statusCode == 200) {
//       int resultLength1 = json.decode(response.body)['results'].length;
//       for (var i = 0; i < resultLength1; i++) {
//         allItems.add(ItemModal(
//           id: json.decode(response.body)['results'][i]['id'],
//           name: json.decode(response.body)['results'][i]['name'].toString(),
//           remaining_qty: json
//               .decode(response.body)['results'][i]['remaining_qty']
//               .toString(),
//         ));
//       }
//       if (resultLength1 >= 10) {
//         String nextUrl1 = json.decode(response.body)['next'];
//         await fetchPaginatedItem(nextUrl1, sharedPreferences);
//       }
//     }
//   }

//   Future fetchItemsFromUrl(
//       {String url1 = ApiConstant.baseUrl + ApiConstant.itemList}) async {
//     try {
//       final SharedPreferences sharedPreferences =
//           await SharedPreferences.getInstance();
//       await fetchPaginatedItem(url1, sharedPreferences);
//       log("API final log");

//       return allItems;
//     } catch (e) {
//       throw Exception(e);
//     }
//   }
}
