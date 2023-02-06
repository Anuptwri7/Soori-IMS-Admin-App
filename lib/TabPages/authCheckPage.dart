
import 'dart:convert';
import 'package:easycare/MainPage/main_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/ApiConstant.dart';
import '../Login/login_screen.dart';
import 'package:http/http.dart' as http;

class AuthCheckPage extends StatefulWidget {
  const AuthCheckPage({Key? key}) : super(key: key);

  @override
  _AuthCheckPageState createState() => _AuthCheckPageState();
}

class _AuthCheckPageState extends State<AuthCheckPage> {

  @override
  void initState() {
    checkRefresh();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          child: Image(
            image: AssetImage("assets/images/logo.png"),
          ),
        ),
      ),
    );
  }
  Future<void> checkRefresh() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // log(pref.getString('refresh_token').toString());
    String finalUrl = pref.getString("subDomain").toString();

    var response = await http.post(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.refreshToken),
      body: ({
        'refresh': pref.getString('refresh_token').toString(),
      }),
    );
    // log(response.body);
    try {
      if (response.statusCode == 200) {
        pref.setString("access_token", json.decode(response.body)['access']);
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const MainScreen()));
      } else if (response.statusCode == 401) {
        pref.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}

