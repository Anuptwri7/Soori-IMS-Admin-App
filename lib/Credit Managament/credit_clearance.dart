// import 'package:flutter/material.dart';

// class CreditClearance extends StatefulWidget {
//   const CreditClearance({ Key? key }) : super(key: key);

//   @override
//   State<CreditClearance> createState() => _CreditClearanceState();
// }

// class _CreditClearanceState extends State<CreditClearance> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold();
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import 'create_credit_clearance.dart';
import 'model/credit_clearance_model.dart';
import 'services/credit_clearance_services.dart';

class CreditClearance extends StatefulWidget {
  const CreditClearance({Key? key}) : super(key: key);

  @override
  State<CreditClearance> createState() => _CreditClearance();
}

class _CreditClearance extends State<CreditClearance> {
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    // log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await fetchCreditClearanceFromUrl("");
    } else {
      return await fetchCreditClearanceFromUrl(_searchItem);
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
                      'Credit Clearance',
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              width: width * 0.5,
                              child: TextFormField(
                                controller: _searchController,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: "Search",
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .subtitle1!
                                      .copyWith(
                                        fontSize: 18,
                                        color: Colors.grey,
                                      ),
                                  prefixIcon: const Icon(Icons.search),
                                  border: InputBorder.none,
                                  errorBorder: InputBorder.none,
                                  errorMaxLines: 4,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                onChanged: (query) {
                                  setState(() {
                                    _searchItem = query;
                                  });
                                },
                                textCapitalization:
                                    TextCapitalization.sentences,
                              ),
                            ),
                            SizedBox(
                              height: 30,
                              width: 70,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateCreditClearance()));
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        const Color(0xff5073d9)),
                                    shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                      const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10)),
                                        //  side: BorderSide(color: Colors.red)
                                      ),
                                    )),
                                child: const Text(
                                  "Add",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        FutureBuilder(
                          future: searchHandling(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              try {
                                final snapshotData = json.decode(snapshot.data);

                                CreditClearanceModel creditClearanceModel =
                                    CreditClearanceModel.fromJson(snapshotData);

                                // allCustomer.clear();

                                return DataTable(
                                  columnSpacing: 5,
                                  horizontalMargin: 2,
                                  columns: [
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * 0.25,
                                        child: const Text(
                                          '	Rcpt. No',
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
                                          'Name',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                    // DataColumn(
                                    //   label: SizedBox(
                                    //     width: width * .15,
                                    //     child: const Text('P Type	'),
                                    //   ),
                                    // ),
                                    DataColumn(
                                      label: SizedBox(
                                        width: width * .2,
                                        child: const Text(
                                          'Amount	',
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
                                          'Date',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ],
                                  rows: List.generate(
                                      creditClearanceModel.results!.length,
                                      (index) => DataRow(
                                            // selected: true,
                                            cells: [
                                              DataCell(
                                                Text(
                                                  creditClearanceModel
                                                      .results![index].receiptNo
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              DataCell(Text(
                                                creditClearanceModel
                                                    .results![index]
                                                    .customerFirstName
                                                    .toString(),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              // DataCell(
                                              //   Text(
                                              //     creditClearanceModel
                                              //                 .results![index]
                                              //                 .paymentType
                                              //                 .toString() ==
                                              //             "1"
                                              //         ? "PAYMENT"
                                              //         : "REFUND",
                                              //     style: const TextStyle(
                                              //         fontWeight:
                                              //             FontWeight.bold,
                                              //         fontSize: 12,
                                              //         color: Colors.black),
                                              //   ),
                                              // ),
                                              DataCell(
                                                Text(
                                                  creditClearanceModel
                                                      .results![index]
                                                      .totalAmount
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
                                                  creditClearanceModel
                                                      .results![index]
                                                      .createdDateBs
                                                      .toString(),
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 12,
                                                      color: Colors.black),
                                                ),
                                              ),
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
