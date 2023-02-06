import 'dart:convert';
import 'dart:developer';
import 'package:easycare/TabPages/customerOrderList.dart';
import 'package:easycare/model/byBatch.dart';
import 'package:easycare/model/itemQuotation.dart';
import 'package:easycare/model/quotationModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../service/customer_api.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';


import '../Constant/ApiConstant.dart';
import '../Notification/controller/notificationController.dart';
import '../model/customer.dart';
import '../service/listingServices.dart';
import 'addModel.dart';


TextEditingController firstName = TextEditingController();
TextEditingController discountName = TextEditingController();
TextEditingController discountRate = TextEditingController();
TextEditingController middleName = TextEditingController();
TextEditingController lastName = TextEditingController();
TextEditingController address = TextEditingController();
TextEditingController contactNumber = TextEditingController();
TextEditingController PanNumber = TextEditingController();
ScrollController scrollController = ScrollController();

class AddCustomerOrderQuotation extends StatefulWidget {
  String? customerName;
  String? itemName;
  int? itemId;
  String? saleCost;
  String? quantity;
  final String customerId ;
  final String itemCategory;

   AddCustomerOrderQuotation({Key? key,required this.customerId, this.customerName,this.itemName,this.itemId,this.saleCost,this.quantity,required this.itemCategory})
      : super(key: key);

  @override
  _AddCustomerOrderQuotationState createState() => _AddCustomerOrderQuotationState();
}

class _AddCustomerOrderQuotationState extends State<AddCustomerOrderQuotation> {
  bool isChecked = false;
  String? _selectedCustomer;
  String? _selectedCustomerName;
  int? _selectedItem;
  int? _seletedBatch;
  String? _selectedBatchNo ;
  bool? _taxable;
  bool? loading = false;
  String? _taxRate;
  String? _selectedItemName;
  double? _remainingQty;
  double? _selectedItemCost;
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  List<AddItemModel> allModelData = [];
  bool isVisibleAddCustomer=false;
  List<String> permission_code_name = [];
  // List<ItemModal> allitemData = [];

  double grandTotal = 0.0, subTotal = 0.0, totalDiscount = 0.0, netAmount = 0.0;


  @override
  void setState(VoidCallback fn) {

    // TODO: implement setState
    super.setState(fn);
    loading = false;
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime? picked;
  CustomerServices customerServices = CustomerServices();
  ListingServices listingServices = ListingServices();
  Batch batch = Batch();
  int selectedId = 0;
  int discountId = 0;
  int itemId = 0;
  bool isVisible = false;
  bool isVisibleBatch = true;
  bool isVisibleSave = false;
  bool isVisibleSaveBatch = true;
  bool? isSuperUser ;

  @override
  void initState() {


    getSuperUser();

    getAllowedFuctionsPermission();
    super.initState();
  }
  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    isSuperUser =  pref.getBool("is_super_user") ;
    log("final superuser"+isSuperUser.toString());

  }

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.black;
    }

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
                  //   color: Color(0xff2557D2)
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      'Create Customer Order',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.grey.shade300,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 100.0),
                      child: Container(
                        child:const Text(
                          "FIFO Wise:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 100.0),
                      child: Checkbox(
                        shape: const CircleBorder(),
                        checkColor: Colors.white,
                        fillColor: MaterialStateProperty.resolveWith(getColor),
                        value: isChecked,
                        onChanged: (bool? value) {

                          setState(() {
                            isChecked = value!;
                            value = isChecked ? isVisibleBatch = false : isVisibleBatch=true;
                            value = isChecked ? isVisibleSave = true : isVisibleSave = false;
                            value = isChecked ? isVisibleSaveBatch = false : isVisibleSaveBatch = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f7ff),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0xfff5f7ff),
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          // crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Customer"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    height: 50,
                                    width: 290,
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
                                    // padding: const EdgeInsets.only(
                                    //
                                    //     left: 10, right: 0, top: 2),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 15.0),
                                      child: Text(
                                        widget.customerName.toString(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                const Text("Item"),

                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    height: 50,
                                    width: 290,
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
                                    // padding: const EdgeInsets.only(
                                    //
                                    //     left: 10, right: 0, top: 2),
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(left: 10, top: 15.0),
                                      child: Text(
                                        widget.itemName.toString(),
                                        textAlign: TextAlign.left,
                                        style: const TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),

                                  ),
                                ),
                              ],
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      Visibility(
                        visible: isVisibleBatch,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("Batch"),
                              const SizedBox(
                                height: 8,
                              ),
                              // Container(
                              //   height: 50,
                              //   width: 270,
                              //   decoration: BoxDecoration(
                              //       color: Colors.white,
                              //       borderRadius: BorderRadius.circular(15),
                              //       boxShadow: const [
                              //         BoxShadow(
                              //           color: Colors.grey,
                              //           spreadRadius: 1,
                              //           blurRadius: 2,
                              //           offset: Offset(4, 4),
                              //         ),
                              //       ]),
                              //   child: FutureBuilder(
                              //     future: batch.BatchFromUrl(widget.itemId.toString()),
                              //     builder: (BuildContext context,
                              //         AsyncSnapshot snapshot) {
                              //       if (snapshot.hasData) {
                              //         try {
                              //           final List<ByBatchModel> snapshotData =
                              //               snapshot.data;
                              //           // customerServices.allItems = [];
                              //           return SearchChoices.single(
                              //             items:
                              //             snapshotData.map((ByBatchModel value) {
                              //
                              //               return (DropdownMenuItem(
                              //                 child: Padding(
                              //                   padding: const EdgeInsets.only(
                              //                       left: 10, top: 5.0),
                              //                   child: Text(
                              //                     "${value.batchNo} Remaining Qty: ${value.remainingQty}",
                              //                     style: const TextStyle(
                              //                         fontSize: 14),
                              //                   ),
                              //                 ),
                              //                 value: value.batchNo.toString(),
                              //                 onTap: () {
                              //                   setState(() {
                              //                     _seletedBatch = value.id;
                              //                     _selectedBatchNo = value.batchNo.toString();
                              //
                              //
                              //                     log('selected item is Taxable or not : ${_seletedBatch.toString()}');
                              //                     log('selected item is Taxable or not : ${value.batchNo.toString()}');
                              //
                              //                   });
                              //                 },
                              //               ));
                              //             }).toSet().toList(),
                              //             value: _selectedBatchNo,
                              //             clearIcon: const Icon(
                              //               Icons.close,
                              //               size: 0,
                              //             ),
                              //             icon: const Visibility(
                              //               visible: false,
                              //               child: Icon(Icons.arrow_downward),
                              //             ),
                              //             underline: DropdownButtonHideUnderline(
                              //                 child: Container()),
                              //             padding: 0,
                              //             hint: const Padding(
                              //               padding:
                              //               EdgeInsets.only(top: 15, left: 8),
                              //               child: Text(
                              //                 "Select Batch",
                              //                 style: TextStyle(fontSize: 15),
                              //               ),
                              //             ),
                              //             searchHint: "Select Batch",
                              //             onChanged: (ByBatchModel? value) {},
                              //             dialogBox: true,
                              //             keyboardType: TextInputType.text,
                              //             isExpanded: true,
                              //           );
                              //         } catch (e) {
                              //           throw Exception(e);
                              //         }
                              //       } else {
                              //         return Opacity(
                              //           opacity: 0.8,
                              //           child: Shimmer.fromColors(
                              //               child: Container(
                              //                 padding: const EdgeInsets.all(8.0),
                              //                 child: const Text(
                              //                     'Select Item First',
                              //                     style: TextStyle(
                              //                         fontSize: 16,
                              //                         color: Colors.black)),
                              //               ),
                              //               baseColor: Colors.black,
                              //               highlightColor: Colors.red),
                              //         );
                              //       }
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      // Padding(
                      //   padding: const EdgeInsets.only(top: 8),
                      //   child: Container(
                      //     height: 50,
                      //     width: 290,
                      //     decoration: BoxDecoration(
                      //         color: Colors.white,
                      //         // border:Border.all(color:Color(0xff2C51A4).withOpacity(0.8) ) ,
                      //         borderRadius: BorderRadius.circular(15),
                      //         boxShadow: const [
                      //           BoxShadow(
                      //             color: Colors.grey,
                      //             spreadRadius: 1,
                      //             blurRadius: 2,
                      //             offset: Offset(4, 4),
                      //           )
                      //         ]),
                      //     // padding: const EdgeInsets.only(
                      //     //
                      //     //     left: 10, right: 0, top: 2),
                      //     child: Padding(
                      //       padding:
                      //       const EdgeInsets.only(left: 10, top: 15.0),
                      //       child: Text(
                      //         widget.saleCost.toString(),
                      //         textAlign: TextAlign.left,
                      //         style: const TextStyle(
                      //           fontSize: 15,
                      //         ),
                      //       ),
                      //     ),
                      //
                      //   ),
                      // ),

                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Sales Price"),
                                    const Text("*",style:TextStyle(color:Colors.red)),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 50,
                                  width: 120,
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
                                  // padding: const EdgeInsets.only(
                                  //
                                  //     left: 10, right: 0, top: 2),
                                  child: Padding(
                                    padding:
                                    const EdgeInsets.only(left: 40, top: 15.0),
                                    child: Text(
                                      widget.saleCost.toString(),
                                      textAlign: TextAlign.left,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Delivery Location"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 150,
                                  child: TextField(
                                    controller: locationController,
                                    keyboardType: TextInputType.text,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                          BorderSide(color: Colors.white)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Delivery location',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(15),
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
                        padding: const EdgeInsets.only(left: 20, right: 10),
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Quantity"),
                                    const Text("*",style: TextStyle(color:Colors.red),),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 155,
                                  child: TextField(
                                    controller: qtyController,
                                    keyboardType: TextInputType.number,
                                    decoration:  InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                          BorderSide(color: Colors.white)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: '${widget.quantity}',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(15),
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow:  [
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
                            const SizedBox(
                              width: 46,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text("Delivery Date"),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 140,
                                  child: InkWell(
                                    onTap: () {
                                      _pickDateDialog();
                                    },
                                    child: TextField(
                                      controller: dateController,
                                      // keyboardType: TextInputType.text,
                                      enabled: false,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        hintText: 'Delivery Date',
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10.0)),
                                            borderSide: BorderSide(
                                                color: Colors.white)),
                                        hintStyle: TextStyle(
                                            fontSize: 14,
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold),
                                        contentPadding: EdgeInsets.all(15),
                                      ),
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
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Discount %"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 45,
                                  width: 165,
                                  child: TextField(
                                    controller: discountPercentageController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.0)),
                                          borderSide:
                                          BorderSide(color: Colors.white)),
                                      filled: true,
                                      fillColor: Colors.white,
                                      hintText: 'Discount %',
                                      hintStyle: TextStyle(
                                          fontSize: 14,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold),
                                      contentPadding: EdgeInsets.all(15),
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
                            const SizedBox(
                              width: 15,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // Center(
                      //   child: SizedBox(
                      //     height: 35,
                      //     width: 80,
                      //     child: ElevatedButton(
                      //       onPressed: () async {
                      //         final SharedPreferences pref = await SharedPreferences.getInstance();
                      //         double quantiy = double.parse(qtyController.text);
                      //         // if (pricecontroller.text.isEmpty) {
                      //         //   Fluttertoast.showToast(
                      //         //       msg: "Enter the price",
                      //         //       backgroundColor: Colors.redAccent,
                      //         //       fontSize: 18);
                      //         // }
                      //         // if (dateController.text.isEmpty) {
                      //         //   Fluttertoast.showToast(
                      //         //       msg: "Enter the date",
                      //         //       backgroundColor: Colors.redAccent,
                      //         //       fontSize: 18);
                      //         // }
                      //         if (qtyController.text.isEmpty || qtyController.text.contains(".")) {
                      //           Fluttertoast.showToast(
                      //               msg: "Enter the Quantity in correct format",
                      //               backgroundColor: Colors.redAccent,
                      //               fontSize: 18);
                      //         }
                      //         if (_remainingQty! < quantiy) {
                      //           Fluttertoast.showToast(
                      //               msg:
                      //               "Quantity can not be greater than stock quantity",
                      //               backgroundColor: Colors.redAccent,
                      //               fontSize: 18);
                      //         } else {
                      //           if (discountPercentageController.text.isEmpty) {
                      //             discountPercentageController.text = "0";
                      //           }
                      //           grandTotal = 0.0;
                      //           subTotal = 0.0;
                      //           totalDiscount = 0.0;
                      //           netAmount = 0.0;
                      //
                      //           setState(() {
                      //             allModelData.add(
                      //               AddItemModel(
                      //                 id: _selectedItem,
                      //                 name: _selectedItemName.toString(),
                      //                 quantity:
                      //                 double.parse(qtyController.text),
                      //                 price:pricecontroller.text.isEmpty?_selectedItemCost:double.parse(pricecontroller.text),
                      //                 discount: double.parse(
                      //                     discountPercentageController.text),
                      //                 discountAmt: pricecontroller.text.isEmpty?
                      //                 (double.parse(
                      //                     discountPercentageController
                      //                         .text) *
                      //                     (_selectedItemCost!*
                      //                         int.parse(qtyController.text)) /
                      //                     100)
                      //                     :(double.parse(
                      //                     discountPercentageController
                      //                         .text) *
                      //                     (double.parse(pricecontroller.text) *
                      //                         int.parse(qtyController.text)) /
                      //                     100),
                      //                 amount:pricecontroller.text.isEmpty?
                      //                 _selectedItemCost! *
                      //                     int.parse(qtyController.text)
                      //                     :
                      //                 double.parse(pricecontroller.text) *
                      //                     int.parse(qtyController.text),
                      //                 totalAfterDiscount: pricecontroller.text.isEmpty?(_selectedItemCost! *
                      //                     int.parse(qtyController.text) -
                      //                     (double.parse(
                      //                         discountPercentageController
                      //                             .text) *
                      //                         (_selectedItemCost! *
                      //                             int.parse(
                      //                                 qtyController.text)) /
                      //                         100)):(double.parse(
                      //                     pricecontroller.text) *
                      //                     int.parse(qtyController.text) -
                      //                     (double.parse(
                      //                         discountPercentageController
                      //                             .text) *
                      //                         (double.parse(
                      //                             pricecontroller.text) *
                      //                             int.parse(
                      //                                 qtyController.text)) /
                      //                         100)),
                      //               ),
                      //             );
                      //             Calc();
                      //             allModelData.isEmpty
                      //                 ? isVisible = false
                      //                 : isVisible = true;
                      //
                      //             log('allModelData.length :' +
                      //                 allModelData.length.toString());
                      //           });
                      //         }
                      //         _selectedBatchNo= "Select Batch";
                      //         _selectedItemName = "Select Item";
                      //         qtyController.clear();
                      //         _remainingQty! >= quantiy
                      //             ? pricecontroller.clear()
                      //             : null;
                      //         discountPercentageController.clear();
                      //       },
                      //       style: ButtonStyle(
                      //           backgroundColor: MaterialStateProperty.all(
                      //               const Color(0xff5073d9)),
                      //           shape: MaterialStateProperty.all<
                      //               RoundedRectangleBorder>(
                      //             const RoundedRectangleBorder(
                      //               borderRadius:
                      //               BorderRadius.all(Radius.circular(10)),
                      //               //  side: BorderSide(color: Colors.red)
                      //             ),
                      //           )),
                      //       child: const Text(
                      //         "Add",
                      //         style: TextStyle(
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 18,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left:2),
                            child:
                          Column(
                            children: [
                              Visibility(
                                visible: isVisibleSave,
                                child: Center(
                                  child: SizedBox(
                                    height: 35,
                                    width: 80,
                                    child: ElevatedButton(
                                      onPressed: () async {

                                        setState(() {

                                          AddProduct();
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 2),
                                          dismissDirection: DismissDirection.down,
                                          content: const Text(
                                            "Product Added Successfully",
                                            style: TextStyle(fontSize: 20),
                                          ),

                                          // margin: EdgeInsets.only(bottom: 70),
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
                                                CustomerOrderListScreen(),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff2658D3)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
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
                              ),
                              Visibility(
                                visible: isVisibleSaveBatch,
                                child: Center(
                                  child: SizedBox(
                                    height: 35,
                                    width: 150,
                                    child: ElevatedButton(
                                      onPressed: () async {

                                        setState(() {

                                          AddProductByBatch();
                                        });

                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                          duration: const Duration(seconds: 2),
                                          dismissDirection: DismissDirection.down,
                                          content: const Text(
                                            "Product Added Successfully",
                                            style: TextStyle(fontSize: 20),
                                          ),

                                          // margin: EdgeInsets.only(bottom: 70),
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
                                                CustomerOrderListScreen(),
                                          ),
                                        );
                                      },
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff2658D3)),
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                            const RoundedRectangleBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              //  side: BorderSide(color: Colors.red)
                                            ),
                                          )),
                                      child: const Text(
                                        "SAVE",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          )
                        ],
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
  Future<void> getAllowedFuctionsPermission() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

    if(isSuperUser == false)
      permission_code_name =  pref.getStringList("permission_code_name")! ;
    log("final codes"+permission_code_name.toString());
  }

  void _pickDateDialog() async {
    picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          const Duration(days: 0),
        ),
        lastDate: DateTime(2030),
        helpText: "Select Delivered Date");
    if (picked != null) {
      setState(() {
        dateController.text = '${picked!.year}-${picked!.month}-${picked!.day}';
      });
    }
  }

  Future AddProduct() async {

    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    log("Qty"+widget.quantity.toString());
    log("Sales Cost"+widget.saleCost.toString());

    double? sales_price = 0.0;
    double? quantity = 0.0;
    double? disc_percentage = 0.0;
    double ?amount = 0.0;
    double? discAmount = 0.0;
    double ?grand_total=0.0;

      disc_percentage= discountPercentageController.text.isEmpty?0:double.parse(discountPercentageController.text);
      sales_price = double.parse(widget.saleCost.toString());
      quantity = qtyController.text.isEmpty?  double.parse(widget.quantity.toString()):double.parse(qtyController.text);
      amount= sales_price*quantity;
      discAmount = (amount * disc_percentage) / 100;
      grand_total = amount - discAmount;
      double finalGrand = double.parse(grand_total.toString());
      double finaldiscAmount = double.parse(discAmount.toString());
      double finalAmount = double.parse(amount.toString());
      log(amount.toString());
      log(discAmount.toString());
      log(grand_total.toString());

    var orderDetails = [];

      orderDetails.add({
        "item": widget.itemId,
        "item_category": widget.itemCategory,
        "taxable": false,
        "discountable": "true",
        "qty": quantity,
        "purchase_cost": 0,
        "sale_cost": widget.saleCost,
        "discount_rate": disc_percentage,
        "discount_amount": finaldiscAmount,
        "tax_rate": 0,
        "tax_amount": 0,
        "gross_amount": finalAmount,
        "net_amount": finalGrand,
        "remarks": "",
        "isNew": "true",
        "unique": "2ed54673-a7b4-489f-91a2-98abe79241ee",
        "cancelled": "false"
      });


    final responseBody = {
      "status": 1,
      "customer": widget.customerId,
      "sub_total": finalAmount,
      "total_discount": finaldiscAmount,
      "total_tax": 0.0,
      "grand_total": finalGrand,
      "remarks": "",
      "total_discountable_amount": finalAmount,
      "total_taxable_amount": 0,
      "total_non_taxable_amount": finalGrand,
      "discount_scheme": '',
      "discount_rate": 0,
      "delivery_location": locationController.text,
      "delivery_date_ad": dateController.text == ""?null:dateController.text,
      "order_details": orderDetails,
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl/${ApiConstant.saveCustomerOrder}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    log(response.body);
    if (response.statusCode == 201) {
      qtyController.clear();
      pricecontroller.clear();
      discountPercentageController.clear();
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }
  Future AddProductByBatch() async {

    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    double? sales_price = 0.0;
    double? quantity = 0.0;
    double? disc_percentage = 0.0;
    double ?amount = 0.0;
    double? discAmount = 0.0;
    double ?grand_total=0.0;

    disc_percentage= discountPercentageController.text.isEmpty?0:double.parse(discountPercentageController.text);
    sales_price = double.parse(widget.saleCost.toString());
    quantity = qtyController.text.isEmpty?  double.parse(widget.quantity.toString()):double.parse(qtyController.text);
    amount= sales_price*quantity;
    discAmount = (amount * disc_percentage) / 100;
    grand_total = amount - discAmount;
    double finalGrand = double.parse(grand_total.toString());
    double finaldiscAmount = double.parse(discAmount.toString());
    double finalAmount = double.parse(amount.toString());
    log(amount.toString());
    log(discAmount.toString());
    log(grand_total.toString());

    var orderDetails = [];


      orderDetails.add({
        "qty": widget.quantity,
        "purchase_cost": 0,
        "sale_cost": widget.saleCost,
        "discountable": true,
        "taxable": false,
        "tax_rate": 0,
        "tax_amount": 0,
        "discount_rate": disc_percentage,
        "discount_amount": discAmount,
        "gross_amount": amount,
        "net_amount": amount,
        "cancelled": false,
        "picked": false,
        "remarks": " ",
        "item": widget.itemId,
        "item_category": widget.itemCategory,
        "purchase_detail": _seletedBatch
      });

    final responseBody = {
    "customer": widget.customerId,
    "discount_scheme": '',
    "total_discount": discAmount,
    "total_tax": 0,
    "sub_total": amount,
    "total_discountable_amount": amount,
    "total_taxable_amount": 0,
    "total_non_taxable_amount": grand_total,
    "delivery_date_ad": "2022-07-25",
    "delivery_date_bs": "string",
    "delivery_location": "string",
    "grand_total": grand_total,
    "remarks": " ",
      "order_details": orderDetails,
    };
    log(json.encode(responseBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl/${ApiConstant.saveCustomerOrderByBatch}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        //ApiConstant.baseUrl + ApiConstant.saveCustomerOrder
        body: json.encode(responseBody));
    log(response.body);
    if (response.statusCode == 201) {
      qtyController.clear();
      pricecontroller.clear();
      discountPercentageController.clear();
      DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(msg: response.body.toString());
    }

    return response;
  }
}


Future OpenDialog(BuildContext context) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
      title: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(),
              margin: const EdgeInsets.only(left: 220),
              child: GestureDetector(
                child: CircleAvatar(
                    radius: 25,
                    backgroundColor: Colors.grey.shade100,
                    child:
                    const Icon(Icons.close, color: Colors.red, size: 20)),
                onTap: () => Navigator.pop(context, true),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 160),
              child: (const Text(
                'New Customer',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 260,
                    child: TextField(
                      controller: firstName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'First Name',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
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
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 125,
                    child: TextField(
                      controller: middleName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Middle Name',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        // focusedBorder: InputBorder. none,
                        // enabledBorder: InputBorder. none,
                        // errorBorder: InputBorder. none,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),

                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
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
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 125,
                    child: TextField(
                      controller: lastName,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Last Name',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
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
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 260,
                    child: TextField(
                      controller: address,
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Address',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        // focusedBorder: InputBorder. none,
                        // enabledBorder: InputBorder. none,
                        // errorBorder: InputBorder. none,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),

                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
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
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: Row(
                children: [
                  Container(
                    height: 45,
                    width: 125,
                    child: TextField(
                      controller: contactNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Contact No.',
                        border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
                        // focusedBorder: InputBorder. none,
                        // enabledBorder: InputBorder. none,
                        // errorBorder: InputBorder. none,
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),

                        contentPadding: EdgeInsets.all(15),
                      ),
                    ),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
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
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    height: 45,
                    width: 125,
                    child: TextField(
                      controller: PanNumber,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Pan No.',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.bold),
                        contentPadding: EdgeInsets.all(15),
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
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              height: 35,
              width: 130,
              //color: Colors.grey,
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: ElevatedButton(
                onPressed: () async {
                  if (firstName.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter the First name.");
                  }
                  if (address.text.isEmpty) {
                    Fluttertoast.showToast(msg: "Please enter address.");
                  }
                  else {
                    createCustomer();
                  }

                  // calculation();
                  // dateController.clear();
                  //  pricecontroller.clear();

                  //  qtycontroller.clear();
                  //  discountPercentageController.clear();

                  //AddProduct1();
                },
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all(const Color(0xff2658D3)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
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
      )),
);




Future createCustomer() async {
  final SharedPreferences sharedPreferences =
  await SharedPreferences.getInstance();
  String finalUrl = sharedPreferences.getString("subDomain").toString();


  final response = await http.post(
      Uri.parse('https://$finalUrl/${ApiConstant.createCustomer}'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
      },
      body: json.encode({
        "device_type": 1,
        "app_type": 1,
        "first_name": firstName.text,
        "middle_name": middleName.text,
        "last_name": lastName.text,
        "address": address.text,
        "phone_no": contactNumber.text,
        "mobile_no": '',
        "email_id": "",
        "pan_vat_no": PanNumber.text,
        "tax_reg_system": 1,
        "active": true,
        "country": 1
      }));
  if (response.statusCode == 201) {
    firstName.clear();
    discountName.clear();
    discountRate.clear();
    middleName.clear();
    lastName.clear();
    address.clear();
    contactNumber.clear();
    PanNumber.clear();

    Fluttertoast.showToast(msg: "Customer created successfully!");
  }

  if (kDebugMode) {
    log('hello${response.statusCode}');
  }
  return response;
}

// Future OpenDialogDiscount(BuildContext context) => showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//           title: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
//             Container(
//               decoration: const BoxDecoration(),
//               margin: const EdgeInsets.only(left: 220),
//               child: GestureDetector(
//                 child: CircleAvatar(
//                     radius: 25,
//                     backgroundColor: Colors.grey.shade100,
//                     child:
//                         const Icon(Icons.close, color: Colors.red, size: 16)),
//                 onTap: () => Navigator.pop(context, true),
//               ),
//             ),
//             Container(
//               padding: const EdgeInsets.only(right: 120),
//               child: (const Text(
//                 'New Discount Scheme',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0, right: 0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: 260,
//                     child: TextField(
//                       controller: discountName,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'First Name',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         // focusedBorder: InputBorder. none,
//                         // enabledBorder: InputBorder. none,
//                         // errorBorder: InputBorder. none,
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),

//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0, right: 0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: 260,
//                     child: TextField(
//                       controller: discountRate,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Rate',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         // focusedBorder: InputBorder. none,
//                         // enabledBorder: InputBorder. none,
//                         // errorBorder: InputBorder. none,
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),

//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Container(
//               height: 35,
//               width: 130,
//               //color: Colors.grey,
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   createDiscountScheme();
//                   // calculation();
//                   // discountRate.clear();
//                   // discountName.clear();

//                   //  qtycontroller.clear();
//                   //  discountPercentageController.clear();

//                   //AddProduct1();
//                 },
//                 style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(const Color(0xff2658D3)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         //  side: BorderSide(color: Colors.red)
//                       ),
//                     )),
//                 child: const Text(
//                   "Add",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
//     );

// Future createDiscountScheme() async {
//   final SharedPreferences sharedPreferences =
//       await SharedPreferences.getInstance();

//   final response = await http.post(
//       Uri.parse(
//           "https://api-soori-ims-staging.dipendranath.com.np/api/v1/core-app/discount-scheme"),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
//       },
//       body: json.encode({
//         "device_type": 1,
//         "app_type": 1,
//         "name": discountName.text,
//         "editable": true,
//         "rate": discountRate.text,
//         "active": true
//       }));
//   if (kDebugMode) {
//     // log(add.toString());
//     log('hello${response.body}');
//   }
//   //log();
//   return response;

//   if (response.statusCode == 200) {
//     // final String responseString = response.body;

//     return response;
//     return response.body;

//     // return AddProductList.fromJson(responseString);
//   }
// }

