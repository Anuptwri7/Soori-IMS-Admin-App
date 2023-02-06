import 'dart:convert';
import 'dart:developer';

import 'package:easycare/TabPages/editCustomer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

import '../model/customerListingsModel.dart';
import '../service/customerListings.dart';

class CustomerListings extends StatefulWidget {
  const CustomerListings({Key? key}) : super(key: key);

  @override
  State<CustomerListings> createState() => _CustomerListings();
}

class _CustomerListings extends State<CustomerListings> {
  // String get $i => null;

  CustomerListingsService customerListingsService = CustomerListingsService();
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';
  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await customerListingsService.fetchCustomerListFromUrl("");
    } else {
      return await customerListingsService
          .fetchCustomerListFromUrl(_searchItem);
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
                      'Customer List',
                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
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
                                CustomerListingModel customerlistingmodel =
                                    CustomerListingModel.fromJson(snapshotData);
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
                                        width: width * 0.10,
                                        child: const Text('Name'),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .25,
                                        child: const Text('Phone'),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .2,
                                        child: const Text('Address'),
                                      ),
                                    ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .2,
                                        child: const Text('PAN'),
                                      ),
                                    ),
                                    // DataColumn(
                                    //   label: SizedBox(
                                    //     width: width * .1,
                                    //     child: const Text('Action'),
                                    //   ),
                                    // ),
                                  ],
                                  rows: List.generate(
                                      customerlistingmodel.results!.length,
                                      (index) => DataRow(
                                            // selected: true,
                                            cells: [
                                              DataCell(
                                                Text(
                                                  customerlistingmodel
                                                      .results![index].firstName
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataCell(Text(
                                                customerlistingmodel
                                                    .results![index].phoneNo
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              DataCell(
                                                Text(
                                                  customerlistingmodel
                                                      .results![index].address
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
                                                  customerlistingmodel
                                                      .results![index].panVatNo
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
                                              // DataCell(
                                              //   GestureDetector(
                                              //     onTap: (){
                                              //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditCustomerPage(
                                              //         name:  customerlistingmodel
                                              //             .results![index].firstName
                                              //             .toString(),
                                              //         phone: customerlistingmodel
                                              //             .results![index].phoneNo
                                              //             .toString(),
                                              //         address: customerlistingmodel
                                              //             .results![index].address
                                              //             .toString(),
                                              //         pan:customerlistingmodel
                                              //             .results![index].panVatNo
                                              //             .toString() ,
                                              //       )));
                                              //     },
                                              //     child: Container(
                                              //       height: 20,
                                              //       width: 20,
                                              //       decoration: BoxDecoration(
                                              //           color: Colors.indigo[900],
                                              //           borderRadius:
                                              //               const BorderRadius
                                              //                       .all(
                                              //                   Radius.circular(
                                              //                       5))),
                                              //       child: const Center(
                                              //         child: FaIcon(
                                              //           FontAwesomeIcons
                                              //               .penToSquare,
                                              //           size: 15,
                                              //           color: Colors.white,
                                              //         ),
                                              //       ),
                                              //     ),
                                              //   ),
                                              // )
                                            ],
                                          )),
                                );
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
