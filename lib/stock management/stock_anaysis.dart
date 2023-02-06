import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'model/stockAnaysisModel.dart';
import 'services/stockAnalysisService.dart';

class StockAnalysisPage extends StatefulWidget {
  const StockAnalysisPage({Key? key}) : super(key: key);

  @override
  State<StockAnalysisPage> createState() => _StockAnalysisPage();
}

class _StockAnalysisPage extends State<StockAnalysisPage> {
  // String get $i => null;

  StockAnalysis stockAnalysis = StockAnalysis();

  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await stockAnalysis.fetchStockListFromUrl("");
    } else {
      return await stockAnalysis.fetchStockListFromUrl(_searchItem);
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
                      'Stock Analaysis',
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
                                StockAnalysisModel stockAnalaysisModel =
                                    StockAnalysisModel.fromJson(snapshotData);
                                // log(snapshotData.toString());

                                return DataTable(
                                    sortColumnIndex: 0,
                                    columnSpacing: 0,
                                    horizontalMargin: 0,

                                    // columnSpacing: 10,

                                    columns: [
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .1,
                                          child: const Text(
                                            'SN',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .3,
                                          child: const Text(
                                            'Name',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .25,
                                          child: const Text(
                                            'Purchase',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .25,
                                          child: const Text(
                                            'Remaining',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        stockAnalaysisModel.results!.length,
                                        (index) => DataRow(
                                              // selected: true,
                                              cells: [
                                                DataCell(
                                                  Text(
                                                    (index + 1).toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    stockAnalaysisModel
                                                        .results![index].name
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                // DataCell(Text(
                                                //   stockAnalaysisModel
                                                //       .results![index].code
                                                //       .toString(),
                                                //   style: const TextStyle(
                                                //       fontSize: 12,
                                                //       fontWeight:
                                                //           FontWeight.bold),
                                                // )),
                                                DataCell(
                                                  Text(
                                                    stockAnalaysisModel
                                                        .results![index]
                                                        .purchaseQty
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
                                                    stockAnalaysisModel
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
                                                // DataCell(
                                                //   Container(
                                                //     height: 20,
                                                //     width: 20,
                                                //     decoration: BoxDecoration(
                                                //         color:
                                                //             Colors.indigo[900],
                                                //         borderRadius:
                                                //             const BorderRadius
                                                //                     .all(
                                                //                 Radius.circular(
                                                //                     5))),
                                                //     child: const Center(
                                                //       child: FaIcon(
                                                //         FontAwesomeIcons
                                                //             .penToSquare,
                                                //         size: 15,
                                                //         color: Colors.white,
                                                //       ),
                                                //     ),
                                                //   ),
                                                // )
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
