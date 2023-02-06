import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:easycare/TabPages/customerOrderList.dart';
import 'package:easycare/TabPages/quotationPage.dart';
import 'package:easycare/model/byBatch.dart';
import 'package:easycare/service/quotationServices.dart';
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
import '../model/itemQuotation.dart';
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

class AddQuotation extends StatefulWidget {

  const AddQuotation({Key? key}) : super(key: key);

  @override
  _AddQuotationState createState() => _AddQuotationState();
}

class _AddQuotationState extends State<AddQuotation> {
  bool isChecked = false;
  String? _selectedCustomer;
  String? _selectedCustomerName;
  int? _selectedItem;
  int? _selectedItemCategory;
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
  QuotationServices quotationServices = QuotationServices();
  double grandTotal = 0.0, subTotal = 0.0, totalDiscount = 0.0, netAmount = 0.0;

  Calc() {
    for (int i = 0; i < allModelData.length; i++) {
      subTotal += allModelData[i].amount!;
      totalDiscount +=
          (allModelData[i].discount! * allModelData[i].amount!) / 100;
      netAmount = (subTotal - totalDiscount);
      grandTotal = netAmount;
      // log("${qtyController.")
      double a = double.parse(qtyController.text);
      log("$a");
      log("${a.runtimeType}");
    }
  }

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

  final player = AudioPlayer();
  void Notification(){
    player.play(AssetSource('images/notificationIMS.mp3'));
  }

  DateTime? picked;
  CustomerServices customerServices = CustomerServices();
  ListingServices listingServices = ListingServices();
  int selectedId = 0;
  String discountInitial = "10.00";
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
                      'Create Quotation',
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
              // Container(
              //   width: MediaQuery.of(context).size.width,
              //   color: Colors.grey.shade300,
              //   child: Row(
              //     children: [
              //       Padding(
              //         padding: const EdgeInsets.only(left: 100.0),
              //         child: Container(
              //           child:const Text(
              //             "FIFO Wise:",
              //             style: TextStyle(
              //                 fontWeight: FontWeight.bold, fontSize: 15),
              //           ),
              //         ),
              //       ),
              //       Padding(
              //         padding: const EdgeInsets.only(right: 100.0),
              //         child: Checkbox(
              //           shape: const CircleBorder(),
              //           checkColor: Colors.white,
              //           fillColor: MaterialStateProperty.resolveWith(getColor),
              //           value: isChecked,
              //           onChanged: (bool? value) {
              //
              //             setState(() {
              //               isChecked = value!;
              //               value = isChecked ? isVisibleBatch = false : isVisibleBatch=true;
              //               value = isChecked ? isVisibleSave = true : isVisibleSave = false;
              //               value = isChecked ? isVisibleSaveBatch = false : isVisibleSaveBatch = true;
              //             });
              //           },
              //         ),
              //       ),
              //     ],
              //   ),
              // ),

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
                                const Text(
                                  "Customer Name",
                                  style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: Container(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width/1.5,
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
                                    padding: const EdgeInsets.only(
                                        left: 10, right: 0, top: 2),
                                    child: FutureBuilder(
                                      future: customerServices
                                          .fetchCustomerFromUrl(),
                                      builder: (BuildContext context,
                                          AsyncSnapshot snapshot) {
                                        if (snapshot.data == null) {
                                          return Opacity(
                                              opacity: 0.8,
                                              child: Shimmer.fromColors(
                                                child: Container(
                                                  padding:
                                                  const EdgeInsets.only(
                                                      top: 5),
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
                                            final List<Customer> snapshotData =
                                                snapshot.data;

                                            // customerServices.allCustomer = [];
                                            return SearchChoices.single(
                                              items: snapshotData
                                                  .map((Customer value) {
                                                return (DropdownMenuItem(
                                                  child: Text(
                                                      "${value.firstName} ${value.lastName}",
                                                      style: const TextStyle(
                                                          fontSize: 14)),
                                                  value: value.firstName,
                                                  onTap: () {
                                                    // setState(() {
                                                    _selectedCustomer =
                                                        value.id;
                                                    _selectedCustomerName =
                                                        value.firstName;
                                                    log('selected Customer name : ${_selectedCustomerName.toString()}');
                                                    log('selected Customer id : ${_selectedCustomer.toString()}');
                                                    // });
                                                  },
                                                ));
                                              }).toList(),
                                              value: _selectedCustomerName,
                                              searchHint: "Select Customer",
                                              icon: const Visibility(
                                                visible: false,
                                                child:
                                                Icon(Icons.arrow_downward),
                                              ),
                                              onChanged: (Customer? value) {},
                                              dialogBox: true,
                                              keyboardType: TextInputType.text,
                                              isExpanded: true,
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
                                                  style:
                                                  TextStyle(fontSize: 15),
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
                                          return Text(
                                              snapshot.error.toString());
                                        }
                                      },
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

                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Select Items"),
                                const SizedBox(
                                  height: 8,
                                ),
                                Container(
                                  height: 50,
                                  width: MediaQuery.of(context).size.width/2.5,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Colors.grey,
                                          spreadRadius: 1,
                                          blurRadius: 5,
                                          offset: Offset(4, 4),
                                        ),
                                      ]),


                                  child: FutureBuilder(
                                    future: quotationServices.fetchItemQuotationFromUrl(),
                                    builder:
                                        (BuildContext context, AsyncSnapshot snapshot) {
                                      if (snapshot.data == null) {
                                        return Opacity(
                                            opacity: 0.8,
                                            child: Shimmer.fromColors(
                                                child: Container(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: const Text('loading Items .....',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black)),
                                                ),
                                                baseColor: Colors.black12,
                                                highlightColor: Colors.white));
                                      }
                                      if (snapshot.hasData) {
                                        try {
                                          final List<ItemQuotation> snapshotData =
                                              snapshot.data;
                                          quotationServices.allItems = [];
                                          return SearchChoices.single(
                                            items: snapshotData.map((ItemQuotation value) {
                                              return (DropdownMenuItem(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 10, top: 5.0),
                                                  child: Text(
                                                    value.name.toString(),
                                                    style: const TextStyle(fontSize: 15),
                                                  ),
                                                ),
                                                value: value.name.toString(),
                                                onTap: () {
                                                  // setState(() {
                                                  _selectedItemCategory = value.itemCategory!.id;
                                                  _selectedItem = value.id;
                                                  _selectedItemName = value.name;
                                                  log('selected item name : ${_selectedItemName.toString()}');
                                                  log('selected item name : ${_selectedItem.toString()}');
                                                  // });
                                                },
                                              ));
                                            }).toList(),
                                            clearIcon: const Icon(
                                              Icons.close,
                                              size: 0,
                                            ),
                                            value: _selectedItemName.toString(),
                                            underline: DropdownButtonHideUnderline(
                                                child: Container()),
                                            padding: 0,
                                            hint: const Padding(
                                              padding: EdgeInsets.only(left: 10, top: 15.0),
                                              child: Text(
                                                "Select Item",
                                                style: TextStyle(fontSize: 15),
                                              ),
                                            ),
                                            icon: const Visibility(
                                              visible: false,
                                              child: Icon(Icons.arrow_downward),
                                            ),
                                            onChanged: (ItemQuotation? value) {},
                                            dialogBox: true,
                                            keyboardType: TextInputType.text,
                                            isExpanded: true,
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
                                      height: 45,
                                      width: MediaQuery.of(context).size.width/2.5,
                                      child: TextField(
                                        controller: pricecontroller,
                                        keyboardType: TextInputType.number,
                                        decoration:  InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10.0)),
                                              borderSide:
                                              BorderSide(color: Colors.white)),
                                          filled: true,
                                          fillColor: Colors.white,
                                          hintText: "${_selectedItemCost==null?"0.0":_selectedItemCost}",
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
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),




                      const SizedBox(
                        height: 25,
                      ),
                      Center(
                        child: SizedBox(
                          height: 35,
                          width: 80,
                          //color: Colors.grey,
                          // padding: const EdgeInsets.only(left: 10, right: 10),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                allModelData.add(
                                  AddItemModel(
                                      name: _selectedItemName.toString(),
                                      price: double.parse(pricecontroller.text),
                                      id: _selectedItem,
                                      itemcategory: _selectedItemCategory
                                  ),
                                );
                              });
                              log(allModelData.length.toString());
                              allModelData.isEmpty
                                  ? isVisible = false
                                  : isVisible = true;
                              pricecontroller.clear();
                            },
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(const Color(0xff5073d9)),
                                shape:
                                MaterialStateProperty.all<RoundedRectangleBorder>(
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
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Visibility(
                        visible: isVisible,
                        child: Column(
                          children: [
                            DataTable(
                              columns: const [
                                DataColumn(
                                    label:
                                    SizedBox(width: 30, child: Text(""))),
                                DataColumn(
                                    label: SizedBox(
                                        width: 50, child: Text(""))),
                                DataColumn(
                                    label: SizedBox(
                                        width: 20, child: Text(""))),

                              ],
                              rows: [
                                for (int i = 0; i < allModelData.length; i++)
                                  DataRow(cells: [

                                    DataCell(SizedBox(
                                        child: Text(
                                          "${allModelData[i].name}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ))),
                                    DataCell(
                                        Text("${allModelData[i].price}")),
                                    DataCell(Text("${allModelData[i].price}")),

                                  ])
                              ],
                            ),



                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      Visibility(
                        visible: allModelData.isEmpty?isVisibleSave:true,
                        child: Container(
                          height: 35,
                          width: 320,
                          //color: Colors.grey,
                          padding: const EdgeInsets.only(left: 120, right: 120),
                          child: ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                saveQuotation();

                              });
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
                              "Save",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
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


  Future saveQuotation() async {

    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    var quotation_details = [];
    for(int i = 0 ; i<allModelData.length;i++){
      quotation_details.add(
          {
            "qty": "1.0",
            "sale_cost": allModelData[i].price,
            "remarks": " ",
            "item": allModelData[i].id,
            "item_category": _selectedItemCategory
          }
      );
    }
    final responeBody = {
      "quotation_details":quotation_details,
      "customer": _selectedCustomer,
      "delivery_date_ad": "2022-07-23",
      "remarks": " "
    };
    log(json.encode(responeBody));
    final response = await http.post(
        Uri.parse('https://$finalUrl/${ApiConstant.saveQuotation}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responeBody));
    log(response.body);
    if (response.statusCode == 201) {
      Notification();
      Fluttertoast.showToast(msg: "Quotation Added Successfully");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>
          const QuotationPage(),
        ),
      );
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


