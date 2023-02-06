// import 'dart:developer';

// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';

// Future AddProduct() async {
//   final SharedPreferences sharedPreferences =
//       await SharedPreferences.getInstance();
//   const String apiUrl =
//       "https://api-soori-ims-staging.dipendranath.com.np/api/v1/customer-order-app/save-customer-order";

//   final response = await http.post(Uri.parse(apiUrl), headers: {
//      'Content-type': 'application/json',
//      'Accept': 'application/json',
//     'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
//   }, body: {
//     "status": 1,
//     "customer": 2,
//     "sub_total": 120,
//     "total_discount": 12,
//     "total_tax": 0,
//     "grand_total": 108,
//     "remarks": "",
//     "order_details": [
//       {
//         "item": 28,
//         "item_category": 8,
//         "taxable": false,
//         "discountable": true,
//         "qty": 1,
//         "purchase_cost": 0,
//         "sale_cost": "120",
//         "discount_rate": "10.00",
//         "discount_amount": 12,
//         "tax_rate": 0,
//         "tax_amount": 0,
//         "gross_amount": 120,
//         "net_amount": 108,
//         "remarks": "",
//         "isNew": true,
//         "unique": "d935c306-1094-46d0-9f18-666b7571587b",
//         "cancelled": false
//       }
//     ],
//     "total_discountable_amount": 120,
//     "total_taxable_amount": 0,
//     "total_non_taxable_amount": 108,
//     "discount_scheme": 1,
//     "discount_rate": 10,
//     "delivery_location": "",
//     "delivery_date_ad": ""
//   });
//   log(response.body);

//   if (response.statusCode == 201) {
//     // final String responseString = response.body;
//     // log(responseString);
//     // return responseString;
//     return response.body;

//     // return AddProductList.fromJson(responseString);
//   }
//   return response;
// }
