import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/Login/Branch/model.dart';
import 'package:easycare/TabPages/authCheckPage.dart';
import 'package:easycare/TabPages/forgetPasswordPage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:swipeable_button_view/swipeable_button_view.dart';


import '../Branch/services/branch_API.dart';
import '../MainPage/main_page.dart';
import 'Branch/branchServices.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController passwordtextEditingController = TextEditingController();
  TextEditingController branchtextEditingController = TextEditingController();
  bool isFinished = false;
  bool isChecked = false;
  bool _passwordVisible = false;
  BranchServices branchServices = BranchServices();
  int? _selecteduser;
  var subDomain = '';
  String dropdownvalueUser = 'Select Branch';
  void validateForm() async {
    if (kDebugMode) {
    }
    if (nametextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Email Address Invalid");

    } else if (passwordtextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is Required.");
    } else if (dropdownvalueUser == "Select Branch") {
      Fluttertoast.showToast(msg: "You have to select branch first");
    } else {
      login();
    }
  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.white;
    }

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
              Container(
                padding: const EdgeInsets.only(top: 100, left: 35),
                child: const Text(
                  "Welcome! ",
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.only(left: 40),
                child: const Text(
                  "Sign in to Continue.",
                  style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                decoration: BoxDecoration(

                    border: Border.all(color: Colors.white, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white
                ),
                width: MediaQuery.of(context).size.width,

                child: FutureBuilder(

                  future: fetchBranchFromUrl(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {

                    if(snapshot.hasError){

                      return Text("Loading");
                    }
                    if (snapshot.hasData) {
                      try {
                        final List<Result> snapshotData = snapshot.data;
                        return DropdownButton<Result>(
                          elevation: 24,
                          isExpanded: true,
                          hint: Text("${dropdownvalueUser.isEmpty?"Select Branch":dropdownvalueUser}"),
                          // value: snapshotData.first,
                          iconSize: 24.0,
                          icon: Icon(
                            Icons.arrow_drop_down_circle,
                            color: Colors.grey,
                          ),
                          underline: Container(
                            height: 2,
                            color: Colors.white,
                          ),
                          items: snapshotData
                              .map<DropdownMenuItem<Result>>((Result items) {
                            return DropdownMenuItem<Result>(
                              value: items,
                              child: Text(items.name.toString()),
                            );
                          }).toList(),
                          onChanged: (Result? newValue) {
                            setState(
                                  () {
                                dropdownvalueUser = newValue!.name.toString();
                                _selecteduser = newValue.id;
                                subDomain = newValue.subDomain.toString();
                                log("--------------------------------"+_selecteduser.toString());
                                log("--------------------------------"+subDomain.toString());
                              },
                            );
                          },
                        );
                      } catch (e) {
                        throw Exception(e);
                      }
                    } else {
                      return Text(snapshot.error.toString());
                    }
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.all(4.0),
                padding: EdgeInsets.all(4.0),
                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white
                ),
                child: TextField(
                  controller: nametextEditingController,
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Username',
                      hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),

              Container(
                margin: EdgeInsets.all(4.0),

                padding: EdgeInsets.all(4.0),

                width: MediaQuery.of(context).size.width,
                // margin: const EdgeInsets.only(left: 10,right: 10),
                decoration: BoxDecoration(

                    border: Border.all(color: Colors.white, width: 3.0),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.white
                ),
                child: TextField(
                  obscureText: !_passwordVisible,
                  enableSuggestions: false,
                  autocorrect: false,
                  controller: passwordtextEditingController,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Password',
                      hintStyle: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                      contentPadding: const EdgeInsets.all(15),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 35.0,
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 35),
                    child: Row(
                      children: [
                        Checkbox(
                          shape: const CircleBorder(),
                          //tristate: true,
                          checkColor: Colors.black,
                          fillColor:
                              MaterialStateProperty.resolveWith(getColor),
                          value: isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              isChecked = value!;
                            });
                          },
                        ),
                        Container(
                          child: const Text(
                            "Remember me",
                            style: TextStyle(color: Colors.white, fontSize: 17),
                          ),
                        )
                      ],
                    ),
                  ),
                  TextButton(
                    onPressed: () =>Navigator.push(context, MaterialPageRoute(builder: (context)=>ForgetPassword())),
                    child: const Text(
                      "Forget Password?",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 35,
              ),
              // Padding(
              //   padding: const EdgeInsets.all(30.0),
              //   child: SwipeableButtonView(
              //     onWaitingProcess : (){
              //       Future.delayed(Duration(seconds: 1),(){
              //         setState(() {
              //           validateForm();
              //           isFinished = true;
              //         });
              //       });
              //
              //     },
              //     onFinish: () async {
              //       validateForm();
              //     },
              //     isFinished: isFinished,
              //     buttonColor: Colors.blue.shade100,
              //
              //     activeColor: Colors.white,
              //     buttonWidget: Container(
              //       child: Icon(
              //         Icons.arrow_forward_ios_rounded,
              //         color: Colors.grey,
              //       ),
              //     ),
              //     buttonText: "Slide to logout",buttontextstyle: TextStyle(color: Colors.black),
              //
              //   ),
              // ),
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
                      "Sign In",
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

  Future<void> login() async {
  List<String> getCodeName =[];
  List<String> getSuperUser = [];
  log("https://${subDomain}/api/v1/user-app/login");
    var response = await http.post(
      Uri.parse("https://${subDomain}/api/v1/user-app/login"),
      body: ({
        'user_name': nametextEditingController.text,
        'password': passwordtextEditingController.text,
      }),
    );

    if (response.statusCode == 200) {
      final SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      sharedPreferences.setString("access_token",
          json.decode(response.body)['tokens']['access'] ?? '#');
      sharedPreferences.setString("refresh_token",
          json.decode(response.body)['tokens']['refresh'] ?? '#');
      sharedPreferences.setString("user_name",
          json.decode(response.body)['user_name'] ?? '#');
      sharedPreferences.setBool("is_super_user",
          json.decode(response.body)['is_superuser']);
      log("user name"+ json.decode(response.body)['is_superuser'].toString());
      sharedPreferences.setString("subDomain" , subDomain);

        for(int i = 0 ; i<json.decode(response.body)["permissions"].length;i++){
          // sharedPreferences.setString("permissions",
          //     json.decode(response.body)['permissions'][i]['code_name']);
          getCodeName.add(json.decode(response.body)["permissions"][i]["code_name"]);
          sharedPreferences.setStringList("permission_code_name", getCodeName);

          log("jhgjh"+getCodeName.toString());
          log(json.decode(response.body)["permissions"].length.toString());
        }

      sharedPreferences.setString(
          "userId", json.decode(response.body)['id'].toString());
      sharedPreferences.setString("user_name", nametextEditingController.text);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const AuthCheckPage()));
    } else {
      Fluttertoast.showToast(msg: "${json.decode(response.body)}");
    }
  }
}
