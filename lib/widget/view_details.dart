import 'dart:convert';


import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

import '../TabPages/addModel.dart';
import '../model/order_summary_list.dart';
import '../service/listingServices.dart';

class ViewDetails extends StatefulWidget {
  final String userId;
  final String userName;
  const ViewDetails({Key? key, required this.userId, required this.userName})
      : super(key: key);

  @override
  _ViewDetailsState createState() => _ViewDetailsState();
}

class _ViewDetailsState extends State<ViewDetails> {
  ListingServices listingservices = ListingServices();

  List<AddItemModel> allModelData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffeff3ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
                    child: Text(
                      widget.userName,
                      style: const TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              FutureBuilder(
                future: listingservices
                    .fetchOrderSummaryListFromUrl(widget.userId.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    try {
                      final snapshotData = json.decode(snapshot.data);

                      OrderSummaryList orderSummaryList =
                          OrderSummaryList.fromJson(snapshotData);

                      return DataTable(
                        columnSpacing: 10,
                        horizontalMargin: 0,
                        // columnSpacing: 10,
                        columns: const [
                          DataColumn(
                            label: SizedBox(
                              width: 50,
                              child: Text('Name'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Text('Quantity'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Center(child: Text('Amount')),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 60,
                              child: Text('Discount'),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          orderSummaryList.orderDetails!.length,
                          (index) => DataRow(
                            // selected: true,
                            cells: [
                              DataCell(
                                Text(orderSummaryList
                                    .orderDetails![index].item!.name
                                    .toString()),
                              ),
                              DataCell(
                                Text(orderSummaryList.orderDetails![index].qty
                                    .toString()),
                              ),
                              DataCell(
                                Text(orderSummaryList
                                    .orderDetails![index].saleCost
                                    .toString()),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(orderSummaryList
                                      .orderDetails![index].discountAmount
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
