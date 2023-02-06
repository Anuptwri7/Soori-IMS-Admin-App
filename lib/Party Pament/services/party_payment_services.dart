import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../Constant/apiConstant.dart';

Future fetchPartyPaymnetFromUrl(String search) async {
  // CustomerList? custom erList;
  final SharedPreferences sharedPreferences =
      await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();

  final response = await http.get(
      Uri.parse('https://$finalUrl/${ApiConstant.partyPayment + search}' ),
      headers: {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      });

  // log(response.body);

  try {
    if (response.statusCode == 200) {
      return response.body;
    }
  } catch (e) {
    throw Exception(e);
  }
}
