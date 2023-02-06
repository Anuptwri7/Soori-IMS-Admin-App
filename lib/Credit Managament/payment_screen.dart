import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Party%20Pament/create_party_payment.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import '../Constant/apiConstant.dart';
import 'model/payement_details_model.dart';
import 'model/payment_model.dart';
import 'services/payment_method_services.dart';
import 'package:http/http.dart' as http;

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String? _selectedPaymentName;
  int? _selectPaymentId;
  List<PaymentDetails> paymentDetails = [];
  bool isVisible = false;
  bool isChecked = false;


  TextEditingController amountController = TextEditingController();
  TextEditingController remarksController = TextEditingController();
  TextEditingController paymentModeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  'Party Payment',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),

              ),

            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 120.0,top:10),
            child: Container(
              child: Text("Your Due Amount : ${dueamount}",style: TextStyle(
                color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold
              ),),
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
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Payment Mode",
                              style: TextStyle(fontSize: 15),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 50,
                              width: 320,
                              child: FutureBuilder(
                                future: fetchPaymentFromUrl(),
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
                                                'Payment Method.....',
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
                                      final List<PaymentMethodModel>
                                          snapshotData = snapshot.data;

                                      return SearchChoices.single(
                                        items: snapshotData
                                            .map((PaymentMethodModel value) {
                                          return (DropdownMenuItem(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text("${value.name} ",
                                                  style: const TextStyle(
                                                      fontSize: 20)),
                                            ),
                                            value: value.name,
                                            onTap: () {


                                                _selectPaymentId = value.id;
                                                _selectedPaymentName = value.name;



                                            },

                                          ));
                                        }).toSet().toList(),
                                        value: _selectedPaymentName,
                                        icon: const Visibility(
                                          visible: false,
                                          child: Icon(Icons.arrow_downward),
                                        ),
                                        dialogBox: true,
                                        keyboardType: TextInputType.text,
                                        isExpanded: true,
                                        onChanged:
                                            (PaymentMethodModel? value) {

                                            },
                                        clearIcon: const Icon(
                                          Icons.close,
                                          size: 0,
                                        ),
                                        padding: 0,
                                        hint: const Padding(
                                          padding:
                                              EdgeInsets.only(top: 15, left: 5),
                                          child: Text(
                                            "Select ...",
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
                        Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: GestureDetector(
                              onTap: () => CreatePaymentMode(context),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: CircleAvatar(
                                    backgroundColor: Colors.grey.shade300,
                                    child: const Icon(Icons.add)),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Amount",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: amountController,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Rs. 0.00',
                            hintStyle: TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold),
                            contentPadding: EdgeInsets.all(15),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Remarks",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextField(
                          controller: remarksController,
                          maxLength: 10,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0)),
                                borderSide: BorderSide(color: Colors.white)),
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Enter Remarks',
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
                    height: 15,
                  ),
                  Container(
                    height: 35,
                    width: 130,
                    //color: Colors.grey,
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (amountController.text.isEmpty) {
                          Fluttertoast.showToast(
                              msg: "Enter the Amount",
                              backgroundColor: Colors.redAccent,
                              fontSize: 18);
                        } else if (_selectedPaymentName == null) {
                          Fluttertoast.showToast(
                              msg: "Select Payment Mode",
                              backgroundColor: Colors.redAccent,
                              fontSize: 18);
                        } else {
                          setState(() {
                            paymentDetails.add(
                              PaymentDetails(
                                name: _selectedPaymentName,
                                paymentMode: _selectPaymentId,
                                amount: int.parse(amountController.text),
                                remarks: remarksController.text,
                              ),
                            );

                            paymentDetails.isEmpty
                                ? isVisible = false
                                : isVisible = true;
                            log(isVisible.toString());
                          });
                          _selectedPaymentName = "Select ...";
                          amountController.clear();
                          remarksController.clear();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xff2658D3)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
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
                  Visibility(
                    visible: isVisible,
                    child: Column(
                      children: [
                        DataTable(
                          columnSpacing: 0,
                          horizontalMargin: 0,
                          columns: [
                            DataColumn(
                              label: SizedBox(
                                width: width * .2,
                                child: const Text(
                                  'P Mode',
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
                                  'Amount',
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
                                  'Remarks',
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
                                  'Action',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ],
                          rows: [
                            for (int i = 0; i < paymentDetails.length; i++)
                              DataRow(cells: [
                                DataCell(SizedBox(
                                    child: Text(
                                  "${paymentDetails[i].name}",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ))),
                                DataCell(Text("${paymentDetails[i].amount}")),
                                DataCell(Text("${paymentDetails[i].remarks}")),
                                DataCell(
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                            color: Colors.redAccent[700],
                                            borderRadius:
                                                const BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(
                                              Icons.delete_outline_outlined,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                        onTap: () {},
                                        child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              color: Colors.indigo[900],
                                              borderRadius:
                                                  const BorderRadius.all(
                                                Radius.circular(8),
                                              )),
                                          child: const Center(
                                              child: FaIcon(
                                                  FontAwesomeIcons.penToSquare,
                                                  size: 15,
                                                  color: Colors.white)),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ])
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            height: 35,
                            width: 80,
                            child: ElevatedButton(
                              onPressed: () async {
                                Navigator.pop(context, paymentDetails);
                              },
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      const Color(0xff2658D3)),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(10)),
                                      //  side: BorderSide(color: Colors.red)
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
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }

  Future CreatePaymentMode(BuildContext context) => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: (const Text(
                  'Create Payment Mode',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                )),
              ),
              Container(
                child: GestureDetector(
                  child: CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.grey.shade100,
                      child:
                          const Icon(Icons.close, color: Colors.red, size: 16)),
                  onTap: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 160,
            child: Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Mode Name*",
                      style: TextStyle(fontSize: 15),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextField(
                      controller: paymentModeController,
                      keyboardType: TextInputType.name,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Enter Mode Name',
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      shape: const CircleBorder(),
                      //tristate: true,
                      checkColor: Colors.black,
                      fillColor: MaterialStateProperty.all(Colors.blue),
                      value: isChecked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChecked = value!;
                        });
                      },
                    ),
                    Container(
                      child: const Text(
                        "Active",
                        style: TextStyle(color: Colors.black, fontSize: 17),
                      ),
                    )
                  ],
                ),
                Container(
                  height: 35,
                  width: 130,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      postPaymentMode().whenComplete(() =>
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            duration: const Duration(seconds: 2),
                            dismissDirection: DismissDirection.down,
                            content: const Text(
                              "Payment Mode Added",
                              style: TextStyle(fontSize: 20),
                            ),
                            padding: const EdgeInsets.all(10),
                            elevation: 10,
                            backgroundColor: Colors.blue,
                            behavior: SnackBarBehavior.floating,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                          )));
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(const Color(0xff2658D3)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
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
          ),
        ),
      );

  Future postPaymentMode() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    final responseBody = {
      "active": true,
      "name": paymentModeController.text,
      "remarks": "Added Payment Mode",
    };

    final response = await http.post(
        Uri.parse('https://$finalUrl/${ApiConstant.postPaymentMode}'),
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
