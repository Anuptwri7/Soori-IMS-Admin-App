// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// import '../Constant/apiConstant.dart';
//
// Future<void> checkRefresh() async {
//   final SharedPreferences pref = await SharedPreferences.getInstance();
//   log("refresh token${pref.getString('refresh_token')}");
//   var response = await http.post(
//     Uri.parse(ApiConstant.baseUrl + ApiConstant.refreshToken),
//     body: ({
//       'refresh': pref.getString('refresh_token'),
//     }),
//   );
//   try {
//     if (response.statusCode == 200) {
//       pref.setString("access_token",
//           json.decode(response.body)['tokens']['access'] ?? '#');
//       // Navigator.pushReplacement(
//       //     context, MaterialPageRoute(builder: (context) => const MainScreen()));
//     } else if (response.statusCode == 401) {
//       pref.clear();
//       // Navigator.pushReplacement(context,
//       //     MaterialPageRoute(builder: (context) => const LoginScreen()));
//     }
//   } catch (e) {
//     throw Exception(e);
//   }
// }
