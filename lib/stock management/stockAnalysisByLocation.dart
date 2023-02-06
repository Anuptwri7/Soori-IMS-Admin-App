import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import 'model/stockAnalysisByLocationModel.dart';
import 'services/stockAnalysiByLocationService.dart';

class StockAnalysisByLocationPage extends StatefulWidget {
  const StockAnalysisByLocationPage({Key? key}) : super(key: key);

  @override
  State<StockAnalysisByLocationPage> createState() =>
      _StockAnalysisByLocationPage();
}

class _StockAnalysisByLocationPage extends State<StockAnalysisByLocationPage> {
  // String get $i => null;

  StockAnalysisByLocation stockAnalysisByLocation = StockAnalysisByLocation();

  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await stockAnalysisByLocation.fetchStockListByLocationFromUrl("");
    } else {
      return await stockAnalysisByLocation
          .fetchStockListByLocationFromUrl(_searchItem);
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
                                StockAnalysisByLocationModel
                                    stockAnalysisByLocationModel =
                                    StockAnalysisByLocationModel.fromJson(
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
                                          child: const Text('Name'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .1,
                                          child: const Text('Code'),
                                        ),
                                      ),
                                      DataColumn(
                                        label: SizedBox(
                                          width: width * .15,
                                          child: const Text('P Qty'),
                                        ),
                                      ),
                                    ],
                                    rows: List.generate(
                                        stockAnalysisByLocationModel
                                            .results!.length,
                                        (index) => DataRow(
                                              // selected: true,
                                              cells: [
                                                DataCell(
                                                  Text(
                                                    stockAnalysisByLocationModel
                                                        .results![index].code
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataCell(
                                                  Text(
                                                    stockAnalysisByLocationModel
                                                        .results![index].items
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ),
                                                DataCell(
                                                  Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                        color:
                                                            Colors.indigo[900],
                                                        borderRadius:
                                                            const BorderRadius
                                                                    .all(
                                                                Radius.circular(
                                                                    5))),
                                                    child: const Center(
                                                      child: FaIcon(
                                                        FontAwesomeIcons
                                                            .penToSquare,
                                                        size: 15,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                )
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
