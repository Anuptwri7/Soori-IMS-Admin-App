import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/Login/login_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';


import '../Branch/services/branch_API.dart';
import '../MainPage/main_page.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({Key? key}) : super(key: key);

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailtextEditingController = TextEditingController();


  bool isChecked = false;
  bool _passwordVisible = false;
  BranchServices branchServices = BranchServices();
  String dropdownValueBranch = "Select Branch";

  void validateForm() async {
    if (kDebugMode) {
    }
    if (emailtextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "You have to enter email first");
    } else {
      forgetPassword();
    }
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      //backgroundColor: Colors.blue,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xff86a2d7),
                Color(0xff3667d4),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  padding: EdgeInsets.only(top:250),

                  child: const Text(
                    "Reset Password! ",
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 40,
              ),

              const SizedBox(
                height: 25,
              ),
              Container(
                width: 250,
                margin: const EdgeInsets.only(left: 50),
                child: TextField(
                  controller:emailtextEditingController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Email',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                ),
              ),
              const SizedBox(
                height: 25.0,
              ),

              const SizedBox(
                height: 35.0,
              ),
              const SizedBox(
                height: 15,
              ),

              const SizedBox(
                height: 35,
              ),
              Container(
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: ElevatedButton(
                    onPressed: () async {
                      validateForm();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      minimumSize: const Size.fromHeight(45),
                      maximumSize: const Size.fromHeight(45),
                    ),
                    child: const Text(
                      "Continue",
                      style: TextStyle(
                        color: Colors.black,
                        // fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> forgetPassword() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    var response = await http.post(
      Uri.parse('https://$finalUrl/${ApiConstant.forgetPassword}' ),
      body: ({
        'email': emailtextEditingController.text,

      }),
    );
    log(response.body);

    if (response.statusCode == 200) {

      Fluttertoast.showToast(msg: "Check Your Email for the reset link ! ");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const LoginScreen()));
    }
    else{
      Fluttertoast.showToast(msg: "${json.decode(response.body)['email']}");

    }
  }
}
