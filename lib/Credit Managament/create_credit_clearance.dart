import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/Credit%20Managament/credit_clearance.dart';
import 'package:easycare/Credit%20Managament/model/payement_details_model.dart';
import 'package:easycare/Credit%20Managament/payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'model/credit_customer_model.dart';
import 'model/get_credit_invoice_model.dart';
import 'services/credit_customer_services.dart';
import 'package:http/http.dart' as http;

class CreateCreditClearance extends StatefulWidget {
  const CreateCreditClearance({Key? key}) : super(key: key);

  @override
  _CreateCreditClearanceState createState() => _CreateCreditClearanceState();
}

class _CreateCreditClearanceState extends State<CreateCreditClearance> {
  int? _selectedCustomer;
  String? _selectedCustomerName;
  String? _selectedSaleNo;
  int? _selectedSaleId;
  String? totalAmount;
  String? dueAmount;
  String? paidAmount;
  List<PaymentDetails> paymentDetails = [];

  var payment = ["Payment", "Return"];
  TextEditingController remarksController = TextEditingController();

  double total = 0.0;
  payingAmount() {
    for (int i = 0; i < paymentDetails.length; i++) {
      total += paymentDetails[i].amount!;
    }
  }

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
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Credit Clearance',
                      style: TextStyle(color: Colors.white, fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Customers",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Container(
                                height: 50,
                                width: 270,
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
                                padding: const EdgeInsets.only(
                                    left: 10, right: 0, top: 2),
                                child: FutureBuilder(
                                  future: fetchCreditCustomerFromUrl(),
                                  builder: (BuildContext context,
                                      AsyncSnapshot snapshot) {
                                    if (snapshot.data == null) {
                                      return Opacity(
                                          opacity: 0.8,
                                          child: Shimmer.fromColors(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.only(top: 5),
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
                                        final List<CreditClearanceCustomerModel>
                                            snapshotData = snapshot.data;

                                        return SearchChoices.single(
                                          items: snapshotData.map(
                                              (CreditClearanceCustomerModel
                                                  value) {
                                            return (DropdownMenuItem(
                                              child: Text("${value.firstName} ",
                                                  style: const TextStyle(
                                                      fontSize: 15)),
                                              value: value.firstName,
                                              onTap: () {
                                                _selectedCustomer = value.id;
                                                _selectedCustomerName =
                                                    value.firstName;
                                                totalAmount =
                                                    value.creditAmount;

                                                paidAmount = value.paidAmount;
                                                dueAmount = value.dueAmount;
                                                log("$_selectedCustomer");
                                                setState(() {});
                                              },
                                            ));
                                          }).toList(),
                                          value: _selectedCustomerName,
                                          searchHint: "Customer list",
                                          icon: const Visibility(
                                            visible: false,
                                            child: Icon(Icons.arrow_downward),
                                          ),
                                          dialogBox: true,
                                          keyboardType: TextInputType.text,
                                          isExpanded: true,
                                          onChanged:
                                              (CreditClearanceCustomerModel?
                                                  value) {},
                                          clearIcon: const Icon(
                                            Icons.close,
                                            size: 0,
                                          ),
                                          padding: 0,
                                          hint: const Padding(
                                            padding: EdgeInsets.only(
                                                top: 15, left: 5),
                                            child: Text(
                                              "Select Customer",
                                              style: TextStyle(fontSize: 15),
                                            ),
                                          ),
                                          underline:
                                              DropdownButtonHideUnderline(
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
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Sale No."),
                            const SizedBox(
                              height: 11,
                            ),
                            Container(
                              height: 50,
                              width: 270,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(4, 4),
                                    ),
                                  ]),
                              child: FutureBuilder(
                                future: getCreditInvoiceFromUrl(
                                    _selectedCustomer.toString()),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.data == null) {
                                    return Opacity(
                                        opacity: 0.8,
                                        child: Shimmer.fromColors(
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(top: 5),
                                            child: const Text('Select .....',
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
                                      final List<GetCreditInvoiceModel>
                                          snapshotData = snapshot.data;

                                      return SearchChoices.single(
                                        items: snapshotData
                                            .map((GetCreditInvoiceModel value) {
                                          return (DropdownMenuItem(
                                            child: Text("${value.saleNo} ",
                                                style: const TextStyle(
                                                    fontSize: 15)),
                                            value: value.saleNo,
                                            onTap: () {
                                              setState(() {
                                                _selectedSaleNo = value.saleNo;
                                                _selectedSaleId = value.saleId;
                                                allCustomer.clear();
                                              });
                                              log("sale no.initial:: $_selectedSaleId");

                                              totalAmount = value.totalAmount;

                                              paidAmount = value.paidAmount;
                                              dueAmount = value.dueAmount;
                                            },
                                          ));
                                        }).toList(),
                                        value: _selectedSaleNo,
                                        searchHint: "Sale No",
                                        icon: const Visibility(
                                          visible: false,
                                          child: Icon(Icons.arrow_downward),
                                        ),
                                        dialogBox: true,
                                        keyboardType: TextInputType.text,
                                        isExpanded: true,
                                        onChanged:
                                            (GetCreditInvoiceModel? value) {},
                                        clearIcon: const Icon(
                                          Icons.close,
                                          size: 0,
                                        ),
                                        padding: 0,
                                        hint: const Padding(
                                          padding:
                                              EdgeInsets.only(top: 15, left: 5),
                                          child: Text(
                                            "Sale Number",
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
                        padding: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Payment Type"),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 50,
                              width: 270,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 1,
                                      blurRadius: 2,
                                      offset: Offset(4, 4),
                                    ),
                                  ]),
                              child: SearchChoices.single(
                                items: payment.map((String value) {
                                  return (DropdownMenuItem(
                                    child: Text("$value ",
                                        style: const TextStyle(fontSize: 15)),
                                    value: value,
                                    onTap: () {},
                                  ));
                                }).toList(),
                                value: _selectedCustomerName,
                                searchHint: "Payment Type",
                                icon: const Visibility(
                                  visible: false,
                                  child: Icon(Icons.arrow_downward),
                                ),
                                dialogBox: true,
                                keyboardType: TextInputType.text,
                                isExpanded: true,
                                onChanged: (String? value) {},
                                clearIcon: const Icon(
                                  Icons.close,
                                  size: 0,
                                ),
                                padding: 0,
                                hint: const Padding(
                                  padding: EdgeInsets.only(top: 15, left: 5),
                                  child: Text(
                                    "Select Pyament",
                                    style: TextStyle(fontSize: 15),
                                  ),
                                ),
                                underline: DropdownButtonHideUnderline(
                                    child: Container()),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Total Amount"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      totalAmount != null
                                          ? "Rs.$totalAmount"
                                          : "Rs.0.00",
                                      style: const TextStyle(fontSize: 18),
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Paid Amount"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      paidAmount != null
                                          ? "Rs.$paidAmount"
                                          : "Rs.0.00",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(18),
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Due Amount"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      dueAmount != null
                                          ? "Rs.$dueAmount"
                                          : "Rs.0.00",
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                  ),
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
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Paying Amount"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 150,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "$total",
                                      style: const TextStyle(fontSize: 18),
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
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Remarks"),
                            const SizedBox(
                              height: 8,
                            ),
                            TextField(
                              controller: remarksController,
                              maxLength: 200,
                              keyboardType: TextInputType.text,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Remarks',
                                hintStyle: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold),
                                contentPadding: EdgeInsets.all(15),
                              ),
                            ),
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 80,
                            child: ElevatedButton(
                              onPressed: paymentDetails.isNotEmpty
                                  ? () async {
                                      setState(() {
                                        savePayment();
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                        duration: const Duration(seconds: 2),
                                        dismissDirection: DismissDirection.down,
                                        content: const Text(
                                          "Bill Cleared Successfully",
                                          style: TextStyle(fontSize: 20),
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        elevation: 10,
                                        backgroundColor: Colors.blue,
                                        behavior: SnackBarBehavior.floating,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                      ));

                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CreditClearance(),
                                        ),
                                      );
                                    }
                                  : null,
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      paymentDetails.isEmpty
                                          ? Colors.lightBlue[600]
                                          : Colors.indigo[900]),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                    ),
                                  )),
                              child: const Text(
                                "Save",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 40,
                          ),
                          SizedBox(
                            height: 40,
                            width: 80,
                            //color: Colors.grey,
                            child: ElevatedButton(
                              onPressed: () async {
                                paymentDetails = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PaymentScreen()),
                                );
                                setState(() {
                                  payingAmount();
                                });
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff5073d9)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      //  side: BorderSide(color: Colors.red)
                                    ),
                                  )),
                              child: const Text(
                                "Pay",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future savePayment() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();

    double total = 0.0;
    var creditPaymentDetails = [];

    log("sale no.$_selectedSaleId");

    for (int i = 0; i < paymentDetails.length; i++) {
      total += paymentDetails[i].amount!;
      creditPaymentDetails.add({
        "payment_mode": paymentDetails[i].paymentMode,
        "amount": paymentDetails[i].amount,
        "remarks": paymentDetails[i].remarks,
      });
    }

    final responseBody = {
      "credit_payment_details": creditPaymentDetails,
      "payment_type": 1,
      "remarks": remarksController.text,
      "sale_master": _selectedSaleId,
      "total_amount": total,
    };
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    log(responseBody.toString());
    final response = await http.post(
        Uri.parse('https://$finalUrl/${ApiConstant.clearCreditInvoice}' ),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    if (response.statusCode == 201) {
    } else if (response.statusCode == 400) {
      FlutterError.onError = (details) => Text(details.toString());
    }
  }
}
