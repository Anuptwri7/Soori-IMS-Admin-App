import 'dart:convert';


import 'package:easycare/Financial%20Report/Quotation%20Report/finanacialPdfDemo.dart';
import 'package:easycare/model/quotationModel.dart';
import 'package:easycare/service/quotationServices.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../Financial Report/Quotation Report/reportAPI.dart';
import '../model/viewQuotation.dart';
import 'addCustomerOrderQuotation.dart';


class ViewDetailsQuotation extends StatefulWidget {
  final String userId;
  final String userName;
  final String customerId;
  final String? quotationNo;
  const ViewDetailsQuotation({Key? key, required this.userId,required this.userName,required this.customerId,this.quotationNo})
      : super(key: key);

  @override
  _ViewDetailsQuotationState createState() => _ViewDetailsQuotationState();
}

class _ViewDetailsQuotationState extends State<ViewDetailsQuotation> {
  // ListingServices listingservices = ListingServices();
  QuotationServices quotationServices= QuotationServices();
  // List<Quotation> allModelData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff3ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 170,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment(-1.0, -0.94),
                    end: Alignment(0.968, 1.0),
                    colors: [Color(0xff2c51a4), Color(0xff6b88e8)],
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
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Center(
                    child: Column(
                      children: [
                        SizedBox(height: 40,),
                        Text(
                          widget.userName,
                          style: const TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        SizedBox(height: 20,),
                        ElevatedButton(
                            onPressed: (){
                              fetchQuotationPdfFromUrl(
                                   widget.userId).whenComplete(
                                    () async {
                                  final status = await Permission.storage.request();
                                  if (status.isGranted) {
                                    if (quotationReport.isNotEmpty) {
                                      Fluttertoast.showToast(msg: "Wait Party Payment Invoice is Generating...",
                                        gravity: ToastGravity.CENTER,
                                        timeInSecForIosWeb: 1,
                                        backgroundColor: Colors.blueGrey,
                                        fontSize: 18,
                                      );
                                      generateInvoice(widget.userName,widget.quotationNo);
                                      quotationReport.clear();
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



                              );;
                            },
                            child: Text("View Quotation Pdf")
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: quotationServices
                    .fetchViewQuotationFromUrl(widget.userId.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    try {
                      final snapshotData = json.decode(snapshot.data);

                      ViewQuotation viewquotation =
                      ViewQuotation.fromJson(snapshotData);

                      return DataTable(
                        columnSpacing: 15,
                        horizontalMargin: 0,
                       // columnSpacing: 10,
                        columns: const [

                          DataColumn(
                            label: SizedBox(
                              width: 50,
                              child: Text('Item'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Text('Sales Cost'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Center(child: Text('Qty')),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 60,
                              child: Text('Cancelled'),
                            ),
                          ),

                        ],
                        rows: List.generate(
                          viewquotation.results!.length,
                              (index) => DataRow(
                            // selected: true,
                            cells: [
                              DataCell(
                                Text(viewquotation.results![index].itemName
                                    .toString()),
                              ),

                              DataCell(
                                Text(viewquotation.results![index].saleCost
                                    .toString()),
                              ),
                              DataCell(
                                Text(viewquotation.results![index].qty
                                    .toString()),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(viewquotation.results![index].cancelled
                                      .toString()),
                                ),
                              ),

                            ],
                          ),
                        ),
                      );
                    } catch (e) {
                      throw Exception(e);
                    }
                  } else {
                    return Shimmer.fromColors(
                      baseColor: const Color.fromRGBO(244, 67, 54, 1),
                      highlightColor: Colors.red,
                      enabled: true,
                      child: const SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Center(child: Text("loading....")),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
