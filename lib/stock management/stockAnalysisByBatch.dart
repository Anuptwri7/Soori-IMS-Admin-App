import 'dart:convert';
import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'model/stockAnalysisByBatchModel.dart';
import 'services/stockAnalysisByBatchServices.dart';

class StockAnalysisByBatchPage extends StatefulWidget {
  const StockAnalysisByBatchPage({Key? key}) : super(key: key);

  @override
  State<StockAnalysisByBatchPage> createState() => _StockAnalysisByBatchPage();
}

class _StockAnalysisByBatchPage extends State<StockAnalysisByBatchPage> {
  // String get $i => null;

  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';
  StockAnalysisByBatch stockAnalysisByBatch = StockAnalysisByBatch();

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return stockAnalysisByBatch.fetchStockListByBatchFromUrl("");
    } else {
      return await stockAnalysisByBatch
          .fetchStockListByBatchFromUrl(_searchItem);
    }
  }

  @override
  void initState() {
    searchHandling();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xffeff3ff),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
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
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Stock Analaysis By Batch',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
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
                          future: searchHandling(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                final snapshotData = json.decode(snapshot.data);
                                // StockAnalysisModel stockAnalaysisModel =
                                //     StockAnalysisModel.fromJson(snapshotData);

                                StockAnalysisByBatchModel
                                    stockAnalysisByBatchModel =
                                    StockAnalysisByBatchModel.fromJson(
                                        snapshotData);

                                log(snapshotData.toString());

                                // log(customerOrderList.count.toString());

                                return DataTable(
                                    sortColumnIndex: 0,
                                    columnSpacing: 0,
                                    horizontalMargin: 0,

                                    // columnSpacing: 10,

                                    columns: [
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * 0.1,
                                          child: const Text('Batch No.'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .1,
                                          child: const Text('Purchase Qty'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .15,
                                          child: const Text('CO.Pending Qty'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .15,
                                          child: const Text('Rem.Qty'),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        stockAnalysisByBatchModel
                                            .results!.length,
                                        (index) => DataRow(
                                              // selected: true,
                                              cells: [
                                                DataCell(
                                                  Text(
                                                    stockAnalysisByBatchModel
                                                        .results![index].batchNo
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataCell(Text(
                                                  stockAnalysisByBatchModel
                                                      .results![index]
                                                      .purchaseQty
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )),
                                                DataCell(
                                                  Text(
                                                    stockAnalysisByBatchModel
                                                        .results![index]
                                                        .customerOrderPendingQty
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    stockAnalysisByBatchModel
                                                        .results![index]
                                                        .remainingQty
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 12,
                                                        color: Colors.black),
                                                  ),
                                                ),
                                              ],
                                            )));
                              } catch (e) {
                                throw Exception(e);
                              }
                            } else {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey,
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
