import 'dart:developer';

import 'package:easycare/Financial%20Report/Credit%20Report/services/credit_pdf_services.dart';
import 'package:easycare/TabPages/homeTabPage.dart';
import 'package:easycare/TabPages/profileTabPage.dart';
import 'package:easycare/service/customer_api.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/customer.dart';
import 'model/user_list_model.dart';
import 'services/credit_report_services.dart';
import 'services/user_list_services.dart';

TextEditingController startDateController = TextEditingController();
TextEditingController endDateController = TextEditingController();

class CreditReportPage extends StatefulWidget {
  const CreditReportPage({Key? key}) : super(key: key);

  @override
  _CreditReportPageState createState() => _CreditReportPageState();
}

class _CreditReportPageState extends State<CreditReportPage> {
  DateTime? pickedStart;
  DateTime? pickedEnd;
  int? _selectedUser;
  String? _selectedUserName;

  String? _selectedCustomer;
  String? _selectedCustomerName;
  CustomerServices customerServices = CustomerServices();
  bool? isSuperUser ;

  List<String> permission_code_name = [];
  String username='';

  void initState(){
    setState(() {
      getSuperUser();
      catchUserName();
      getAllowedFuctions();
      isSuperUser;
    });


    super.initState();
  }

  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    isSuperUser = pref.getBool("is_super_user") ;
    log("final superuser for report"+isSuperUser.toString());
  }
  Future<void> getAllowedFuctions() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(isSuperUser == false)
      permission_code_name =  pref.getStringList("permission_code_name")! ;
    log("final codes"+permission_code_name.toString());
  }
  Future<void> catchUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("user_name").toString() ;
    log("codes name"+ pref.getString("user_name").toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.0, -0.94),
                        end: Alignment(0.968, 1.0),
                        colors: [Color(0xff2c51a4), Color(0xff6b88e8)],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.0),
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      color: Colors.blue),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(),
                      child: Text(
                        'Credit Report',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "User",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(4, 4),
                              )
                            ]),
                        padding:
                            const EdgeInsets.only(left: 10, right: 0, top: 2),
                        child: FutureBuilder(
                          future: fetchUserListFromUrl(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Opacity(
                                  opacity: 0.8,
                                  child: Shimmer.fromColors(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: const Text('Loading User .....',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black)),
                                    ),
                                    baseColor: Colors.black12,
                                    highlightColor: Colors.white,
                                  ));
                            }
                            if (snapshot.hasData && isSuperUser == true || permission_code_name.contains("self_view_customer_order_report")) {

                              try {
                                final List<UserList> snapshotData =
                                    snapshot.data;
                                return SearchChoices.single(
                                  items: snapshotData.map((UserList value) {
                                    return (DropdownMenuItem(
                                      child: Text("${value.userName} ",
                                          style: const TextStyle(fontSize: 14)),
                                      value: value.userName,
                                      
                                      onTap: () {
                                        _selectedUser = value.id;
                                        _selectedUserName = permission_code_name.contains("self_view_customer_order_report")?username:value.userName;
                                       
                                      },
                                    ));
                                  }).toList(),
                                  value: _selectedUserName,
                                  searchHint: "Select User",
                                  icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward),
                                  ),
                                  onChanged:permission_code_name.contains("self_view_customer_order_report")?null: (UserList? value) {},
                                  dialogBox: true,
                                  keyboardType: TextInputType.text,
                                  isExpanded: true,
                                  clearIcon: const Icon(
                                    Icons.close,
                                    size: 0,
                                  ),
                                  padding: 0,
                                  hint: const Padding(
                                    padding: EdgeInsets.only(top: 15, left: 5),
                                    child: Text(
                                      "Select User",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  underline: DropdownButtonHideUnderline(
                                      child: Container()),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Customer",
                        style: TextStyle(fontSize: 18),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.grey,
                                spreadRadius: 1,
                                blurRadius: 2,
                                offset: Offset(4, 4),
                              )
                            ]),
                        padding:
                            const EdgeInsets.only(left: 10, right: 0, top: 2),
                        child: FutureBuilder(
                          future: customerServices.fetchCustomerFromUrl(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.data == null) {
                              return Opacity(
                                  opacity: 0.8,
                                  child: Shimmer.fromColors(
                                    child: Container(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: const Text(
                                          'Loading Customer .....',
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Colors.black)),
                                    ),
                                    baseColor: Colors.black12,
                                    highlightColor: Colors.white,
                                  ));
                            }
                            if (snapshot.hasData) {
                              try {
                                final List<Customer> snapshotData =
                                    snapshot.data;
                                return SearchChoices.single(
                                  items: snapshotData.map((Customer value) {
                                    return (DropdownMenuItem(
                                      child: Text(
                                          "${value.firstName} ${value.lastName}",
                                          style: const TextStyle(fontSize: 14)),
                                      value: value.firstName,
                                      onTap: () {
                                        _selectedCustomer = value.id;
                                        _selectedCustomerName = value.firstName;
                                      },
                                    ));
                                  }).toList(),
                                  value: _selectedCustomerName,
                                  searchHint: "Select Customer",
                                  icon: const Visibility(
                                    visible: false,
                                    child: Icon(Icons.arrow_downward),
                                  ),
                                  onChanged: (Customer? value) {},
                                  dialogBox: true,
                                  keyboardType: TextInputType.text,
                                  isExpanded: true,
                                  clearIcon: const Icon(
                                    Icons.close,
                                    size: 0,
                                  ),
                                  padding: 0,
                                  hint: const Padding(
                                    padding: EdgeInsets.only(top: 15, left: 5),
                                    child: Text(
                                      "Select Customer",
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                  underline: DropdownButtonHideUnderline(
                                      child: Container()),
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
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Start Date",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/2.5,
                            child: InkWell(
                              onTap: () {
                                _pickStartDateDialog();
                              },
                              child: TextField(
                                controller: startDateController,
                                enabled: false,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'Start Date',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(4, 4),
                                  )
                                ]),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "End Date",
                            style: TextStyle(fontSize: 18),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 45,
                            width: MediaQuery.of(context).size.width/2.5,
                            child: InkWell(
                              onTap: () {
                                _pickEndDateDialog();
                              },
                              child: TextField(
                                controller: endDateController,
                                enabled: false,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText: 'End Date',
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide:
                                          BorderSide(color: Colors.white)),
                                  hintStyle: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold),
                                  contentPadding: EdgeInsets.all(15),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                                boxShadow: const [
                                  BoxShadow(
                                    color: Colors.grey,
                                    spreadRadius: 1,
                                    blurRadius: 2,
                                    offset: Offset(4, 4),
                                  )
                                ]),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                    onPressed: () =>permission_code_name.contains("self_view_customer_order_report") || isSuperUser == true? {
                          fetchcreditReport(
                            _selectedCustomer==null?'':_selectedCustomer.toString(),
                            _selectedUser==null?"":_selectedUser.toString(),
                            startDateController.text,
                            endDateController.text,
                          ).whenComplete(
                            () async {
                              final status = await Permission.storage.request();
                              if (status.isGranted) {
                                if (creditReport.isNotEmpty) {
                                   Fluttertoast.showToast(msg: "Wait Credit Invoice is Generating...",
                                     gravity: ToastGravity.CENTER,
                                       timeInSecForIosWeb: 1,
                                     backgroundColor: Colors.blueGrey,
                                     fontSize: 18,
                                   );
                                  generateCreditReport();
                                  startDateController.clear();
                                  endDateController.clear();
                                  creditReport.clear();
                                } else {
                                  Fluttertoast.showToast(msg: "Data Not Found",
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    fontSize: 18,
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                    msg: "Permission Deined",
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  fontSize: 18,);
                              }
                            },
                          ),
                        }:Fluttertoast.showToast(msg: "Permission not granted"),
                    child: const Text("Generate"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _pickStartDateDialog() async {
    pickedStart = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        helpText: "Select start Date");
    if (pickedStart != null) {
      setState(() {
        startDateController.text =
            '${pickedStart!.year}-${pickedStart!.month}-${pickedStart!.day}';
      });
    }
  }

  void _pickEndDateDialog() async {
    pickedEnd = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime.now(),
        helpText: "Select End Date");
    if (pickedEnd != null) {
      setState(() {
        endDateController.text =
            '${pickedEnd!.year}-${pickedEnd!.month}-${pickedEnd!.day}';
      });
    }
  }
}
