import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shimmer/shimmer.dart';

import '../Credit Report/model/user_list_model.dart';
import '../Credit Report/services/user_list_services.dart';
import 'Services/reportApi.dart';
import 'Services/supplierAPI.dart';
import 'finanacialPdfDemo.dart';
import 'model/supplierListModel.dart';

TextEditingController StartdateController = TextEditingController();
TextEditingController EnddateController = TextEditingController();

class PartyReportPage extends StatefulWidget {
  const PartyReportPage({Key? key}) : super(key: key);

  @override
  _PartyReportPageState createState() => _PartyReportPageState();
}

class _PartyReportPageState extends State<PartyReportPage> {
  DateTime? pickedStart;
  DateTime? pickedEnd;
  int? _selectedUser;
  String? _selectedUserName;

  SupplierServices supplierServices = SupplierServices();
  int? _selectedSupplier;
  String? _selectedSupplierName;

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
                        'Party Report',
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
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(4, 4),
                          )
                        ]),
                    padding: const EdgeInsets.only(left: 10, right: 0, top: 2),
                    child: FutureBuilder(
                      future: fetchUserListFromUrl(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Opacity(
                              opacity: 0.8,
                              child: Shimmer.fromColors(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: const Text('Loading Customer .....',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ),
                                baseColor: Colors.black12,
                                highlightColor: Colors.white,
                              ));
                        }
                        if (snapshot.hasData) {
                          try {
                            final List<UserList> snapshotData = snapshot.data;
                            // customerServices.allCustomer = [];
                            return SearchChoices.single(
                              items: snapshotData.map((UserList value) {
                                return (DropdownMenuItem(
                                  child: Text("${value.userName} ",
                                      style: const TextStyle(fontSize: 14)),
                                  value: value.userName,
                                  onTap: () {
                                    // setState(() {
                                    _selectedUser = value.id;
                                    _selectedUserName = value.userName;
                                    log('selected Customer id : ${_selectedUser.toString()}');
                                    log('selected Customer name : ${_selectedUserName.toString()}');
                                    // });
                                  },
                                ));
                              }).toList(),
                              value: _selectedUserName,
                              searchHint: "Select User",
                              icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward),
                              ),
                              onChanged: (UserList? value) {},
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: Offset(4, 4),
                          )
                        ]),
                    padding: const EdgeInsets.only(left: 10, right: 0, top: 2),
                    child: FutureBuilder(
                      future: supplierServices.fetchSupplierListFromUrl(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data == null) {
                          return Opacity(
                              opacity: 0.8,
                              child: Shimmer.fromColors(
                                child: Container(
                                  padding: const EdgeInsets.only(top: 5),
                                  child: const Text('Loading Supplier .....',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.black)),
                                ),
                                baseColor: Colors.black12,
                                highlightColor: Colors.white,
                              ));
                        }
                        if (snapshot.hasData) {
                          try {
                            final List<supplierList> snapshotData =
                                snapshot.data;
                            // customerServices.allCustomer = [];
                            return SearchChoices.single(
                              items: snapshotData.map((supplierList value) {
                                return (DropdownMenuItem(
                                  child: Text("${value.name} ",
                                      style: const TextStyle(fontSize: 14)),
                                  value: value.name,
                                  onTap: () {
                                    // setState(() {
                                    _selectedSupplier = value.id;
                                    _selectedSupplierName = value.name;
                                    log('selected Customer id : ${_selectedSupplier.toString()}');
                                    log('selected Customer name : ${_selectedSupplierName.toString()}');
                                    // });
                                  },
                                ));
                              }).toList(),
                              value: _selectedSupplierName,
                              searchHint: "Select Supplier",
                              icon: const Visibility(
                                visible: false,
                                child: Icon(Icons.arrow_downward),
                              ),
                              onChanged: (supplierList? value) {},
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
                                  "Select Supplier",
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
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15, left: 10.0),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Start Date"),
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
                                controller: StartdateController,

                                // keyboardType: TextInputType.text,
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
                          const Text("End Date"),
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
                                controller: EnddateController,
                                // keyboardType: TextInputType.text,
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
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                        fetchPdfFromUrl(
                          _selectedSupplier==null?'':_selectedSupplier.toString(),
                          _selectedUser==null?"":_selectedUser.toString(),
                        ).whenComplete(
                              () async {
                            final status = await Permission.storage.request();
                            if (status.isGranted) {
                              if (partyReport.isNotEmpty) {
                                Fluttertoast.showToast(msg: "Wait Party Payment Invoice is Generating...",
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.blueGrey,
                                  fontSize: 18,
                                );
                                generateInvoice();
                                StartdateController.clear();
                                EnddateController.clear();
                                partyReport.clear();
                              } else {
                                Fluttertoast.showToast(msg: "Data Not Found",
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  fontSize: 18,);
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



                      );
                    },
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
        helpText: "Select Delivered Date");
    if (pickedStart != null) {
      setState(() {
        StartdateController.text =
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
        helpText: "Select Delivered Date");
    if (pickedEnd != null) {
      setState(() {
        EnddateController.text =
            '${pickedEnd!.year}-${pickedEnd!.month}-${pickedEnd!.day}';
      });
    }
  }
}
