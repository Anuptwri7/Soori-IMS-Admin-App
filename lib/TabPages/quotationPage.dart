import 'dart:convert';
import 'dart:developer';

import 'package:easycare/TabPages/addCustomerOrderQuotation.dart';
import 'package:easycare/TabPages/editQuotation.dart';
import 'package:easycare/TabPages/viewQuotation.dart';
import 'package:easycare/model/quotationModel.dart';
import 'package:easycare/service/quotationServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../model/viewQuotation.dart';
import 'addQuotation.dart';

class QuotationPage extends StatefulWidget {
  const QuotationPage({Key? key}) : super(key: key);

  @override
  _QuotationPageState createState() => _QuotationPageState();
}

class _QuotationPageState extends State<QuotationPage> {
  QuotationServices quotationServices = QuotationServices();
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';
  bool isVisibleAdd =false;
  bool isVisibleEdit = false;
  bool isVisibleCancel = false;
  List<String> permission_code_name = [];
  bool? isSuperUser;

  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    isSuperUser =  pref.getBool("is_super_user") ;
    log("final superuser"+isSuperUser.toString());
  }
  Future<void> getAllowedFuctions() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(isSuperUser == false)
      permission_code_name =  pref.getStringList("permission_code_name")! ;
    log("final codes"+permission_code_name.toString());
  }
  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await quotationServices.fetchQuotationFromUrl("");
    } else {
      return await quotationServices.fetchQuotationFromUrl(_searchItem);
    }
  }

  Future CancelQuotation(String cancelId) async {
    return await quotationServices.cancelQuotationFromUrl(cancelId);
  }

  @override
  void initState() {
    getSuperUser();
    getAllowedFuctions();
    quotationServices.fetchQuotationFromUrl("");
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            children: [
              Container(
                height: 150,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, -0.94),
                    end: Alignment(0.968, 1.0),
                    colors: [Color(0xff2557D2), Color(0xff6b88e8)],
                    stops: [0.0, 1.0],
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0.0),
                    topRight: Radius.circular(0.0),
                    bottomRight: Radius.circular(10.0),
                    bottomLeft: Radius.circular(10.0),
                  ),
                  //   color: Color(0xff2557D2)
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Quotation',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 100.0),
                child: Row(
                  children: [
                    Container(
                      height: 20,
                      width: 20,
                      color: Colors.blue.shade50,
                    ),
                    Text("Permitted"),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      height: 20,
                      width: 20,
                      color: Colors.red.shade100,
                    ),
                    Text("Cancelled"),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  width: width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0xffeff3ff),
                        offset: Offset(5, 8),
                        spreadRadius: 5,
                        blurRadius: 12,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, right: 5, left: 5, bottom: 50),
                    child: Column(
                      children: [


                      Visibility(
                         visible:true,
                    // permission_code_name.contains("add_quotation")|| isSuperUser == true ?true:isVisibleAdd;
                         child: Padding(

                           padding: const EdgeInsets.only(left: 200),
                           child: ElevatedButton(onPressed: ()=> permission_code_name.contains("add_quotation")|| isSuperUser == true ?Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>AddQuotation())):Fluttertoast.showToast(msg: "You dont have permission . Please contact IT branch"),
                               child: const Text("Add +"),
                           ),
                         ),
                       ),
                        TextFormField(
                          controller: _searchController,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            hintText: "Search",
                            hintStyle:
                                Theme.of(context).textTheme.subtitle1!.copyWith(
                                      fontSize: 18,
                                      color: Colors.grey,
                                    ),
                            // filled: true,
                            // fillColor: Theme.of(context).backgroundColor,
                            prefixIcon: const Icon(Icons.search),
                            border: InputBorder.none,
                            errorBorder: InputBorder.none,
                            errorMaxLines: 4,
                          ),
                          // validator: validator,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          onChanged: (query) {
                            setState(() {
                              _searchItem = query;
                            });
                          },
                          textCapitalization: TextCapitalization.sentences,
                        ),
                        FutureBuilder(
                          // future: customerServices
                          //     .fetchOrderListFromUrl(_searchItem),
                          future: searchHandling(),

                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                final snapshotData = json.decode(snapshot.data);
                                Quotation quotation =
                                    Quotation.fromJson(snapshotData);
                                // ViewQuotation viewQuotation = ViewQuotation.fromJson(snapshotData);
                                //
                                //  log(viewQuotation.results.length.toString());

                                return DataTable(
                                    sortColumnIndex: 0,
                                    sortAscending: true,
                                    columnSpacing: 0,
                                    horizontalMargin: 0,

                                    // columnSpacing: 10,

                                    columns: [
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .2,
                                          child: const Text(
                                            'Quotation',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .2,
                                          child: const Text(
                                            'Customer',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .15,
                                          child: const Text(
                                            'Created By',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .2,
                                          child: const Center(
                                              child: Text(
                                            'Action',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          )),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        quotation.results.length,
                                        (index) => DataRow(
                                              // selected: true,
                                              cells: [
                                                DataCell(
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: quotation
                                                                    .results[
                                                                        index]
                                                                    .cancelled
                                                                    .toString() ==
                                                                "true"
                                                            ? Colors
                                                                .red.shade100
                                                            : Colors
                                                                .blue.shade50),
                                                    height: 40,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              10.0),
                                                      child: Text(
                                                        quotation.results[index]
                                                            .quotationNo
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 11,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                DataCell(Container(
                                                  height: 40,
                                                  child: Container(
                                                    decoration: BoxDecoration(
                                                        color: quotation
                                                                    .results[
                                                                        index]
                                                                    .cancelled
                                                                    .toString() ==
                                                                "true"
                                                            ? Colors
                                                                .red.shade100
                                                            : Colors
                                                                .blue.shade50),
                                                    child: Center(
                                                      child: Text(
                                                        quotation.results[index]
                                                            .customerFirstName
                                                            .toString(),
                                                        style: const TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ),
                                                )),
                                                DataCell(
                                                  Container(
                                                    height: 40,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: quotation
                                                                      .results[
                                                                          index]
                                                                      .cancelled
                                                                      .toString() ==
                                                                  "true"
                                                              ? Colors
                                                                  .red.shade100
                                                              : Colors.blue
                                                                  .shade50),
                                                      height: 20,
                                                      width: 60,
                                                      child: Center(
                                                        child: Text(
                                                          quotation
                                                              .results[index]
                                                              .createdByUserName
                                                              .toString(),
                                                          style:
                                                              const TextStyle(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .black),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                          
                                                DataCell(
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        color: quotation
                                                                    .results[
                                                                        index]
                                                                    .cancelled
                                                                    .toString() ==
                                                                "true"
                                                            ? Colors
                                                                .red.shade100
                                                            : Colors
                                                                .blue.shade50),
                                                    height: 40,
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Visibility(
                                                          visible: permission_code_name.contains("update_quotation")|| isSuperUser == true ?true:isVisibleEdit,
                                                          child: InkWell(
                                                            onTap: () {
                                                              // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditQuotation()));
                                                               Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => EditQuotation(

                                                                    customerId: quotation.results[index].customer!.id,
                                                                      orderId :quotation
                                                                          .results[
                                                                      index]
                                                                          .id,
                                                                      customerFirstName:  quotation
                                                                          .results[index]
                                                                          .customerFirstName
                                                                          .toString()),
                                                                ),
                                                              );
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                      color: quotation.results[index].cancelled.toString() ==
                                                                              "true"
                                                                          ? Colors
                                                                              .indigoAccent
                                                                              .shade100
                                                                          : Colors
                                                                              .indigo,
                                                                      borderRadius:
                                                                          const BorderRadius
                                                                              .all(
                                                                        Radius
                                                                            .circular(
                                                                                5),
                                                                      )),
                                                              child: const Center(
                                                                  child: FaIcon(
                                                                      FontAwesomeIcons
                                                                          .penToSquare,
                                                                      size: 12,
                                                                      color: Colors
                                                                          .white)),
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                       visible: true,
                                                            child:InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                    ViewDetailsQuotation(
                                                                      userId: quotation
                                                                          .results[
                                                                      index]
                                                                          .id
                                                                          .toString(),
                                                                      userName: quotation
                                                                          .results[
                                                                      index]
                                                                          .customer!
                                                                          .firstName
                                                                          .toString(),
                                                                      customerId : quotation.results[index].customer!.id.toString(),
                                                                      quotationNo: quotation.results[index].quotationNo.toString(),

                                                                    ),
                                                              ),
                                                            );
                                                          },
                                                          child: Container(
                                                            height: 20,
                                                            width: 20,
                                                            decoration: BoxDecoration(
                                                                color: quotation
                                                                    .results[
                                                                index]
                                                                    .cancelled
                                                                    .toString() ==
                                                                    "true"
                                                                    ? Colors
                                                                    .indigoAccent
                                                                    .shade100
                                                                    : Colors
                                                                    .indigo,
                                                                borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        5))),
                                                            child: const Center(
                                                              child: FaIcon(
                                                                FontAwesomeIcons
                                                                    .eye,
                                                                size: 12,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                          ),
                                                        )),
                                                        Visibility(
                                                          visible: permission_code_name.contains("cancel_quotation")|| isSuperUser == true ?true:isVisibleCancel,
                                                          child: InkWell(
                                                            onTap: () {
                                                              log("yes");
                                                              setState(() {});
                                                              // log(viewQuotation.results[index].item.toString());

                                                              quotation
                                                                          .results[
                                                                              index]
                                                                          .cancelled
                                                                           ==
                                                                    false
                                                                  ? CancelQuotation(
                                                                      quotation
                                                                          .results[
                                                                              index]
                                                                          .id
                                                                          .toString(),




                                                                    )
                                                                  : null;
                                                            },
                                                            child: Container(
                                                              height: 20,
                                                              width: 20,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: quotation
                                                                            .results[
                                                                                index]
                                                                            .cancelled
                                                                            .toString() ==
                                                                        "true"
                                                                    ? Colors
                                                                        .red[300]
                                                                    : Colors.redAccent[
                                                                        700],
                                                                borderRadius:
                                                                    const BorderRadius
                                                                        .all(
                                                                  Radius.circular(
                                                                      5),
                                                                ),
                                                              ),
                                                              child: const Center(
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .trash,
                                                                  size: 12,
                                                                  color:
                                                                  Colors.white,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )));
                              } catch (e) {
                                throw Exception(e);
                              }
                            } else {
                              return Opacity(
                                opacity: 0.8,
                                child: Shimmer.fromColors(
                                    child: const SizedBox(
                                      child: Text(
                                        'Loading All Quotation .....',
                                        style: TextStyle(
                                            fontSize: 18, color: Colors.grey),
                                      ),
                                    ),
                                    baseColor: Colors.black,
                                    highlightColor: Colors.white),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
