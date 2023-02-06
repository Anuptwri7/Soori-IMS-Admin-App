import 'dart:convert';
import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';
import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/TabPages/quotationPage.dart';
import 'package:easycare/model/itemQuotation.dart';
import 'package:easycare/model/quotationOrderSummary.dart';
import 'package:easycare/service/quotationServices.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../service/customer_api.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';

import '../AddProduct/add_product.dart';
import '../TabPages/addModel.dart';
import '../TabPages/moreTabPage.dart';
import '../model/customer.dart';
import '../model/order_summary_list.dart';
import '../service/listingServices.dart';

class EditQuotation extends StatefulWidget {
  final int? customerId;
  final int? orderId;

  // final int? userId;
  final String customerFirstName;

  const EditQuotation(
      {Key? key,
      required this.customerId,
      required this.orderId,
      required this.customerFirstName})
      : super(key: key);

  @override
  _EditQuotationState createState() => _EditQuotationState();
}

class _EditQuotationState extends State<EditQuotation> {
  int? _selectedItemCategory;
  int? _selectedItem;
  String? _selectedItemName;
  bool isVisible = false;
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  List<AddItemModel> allModelData = [];
  QuotationServices quotationServices = QuotationServices();

  // Future CancelSingleOrder(String cancelId) async {
  //   return await listingservices.CancelSingleOrderFromUrl(cancelId);
  // }

  var orderSummary = [];
  double grandTotal = 0.0,
      subTotal = 0.0,
      totalDiscount = 0.0,
      finaldiscount = 0.0,
      x = 0.0;

  DateTime? picked;
  CustomerServices customerServices = CustomerServices();
  int selectedId = 0;
  String discountInitial = "0.00";
  int discountId = 0;
  int itemId = 0;
  String? itemName = " ";

  @override
  void initState() {
    getOrderSummary();
    log("customer::::::::::::::::::" + widget.customerId.toString());
    log("order::::::::::::::::::" + widget.orderId.toString());
    // TODO: implement initState
    super.initState();
  }

  Future<void> getOrderSummary() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    itemName = prefs.getString("item_name").toString();
    log("final superuser" + itemName.toString());
  }

  final player = AudioPlayer();
  void Notification(){
    player.play(AssetSource('images/notificationIMS.mp3'));
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
                  //   color: Color(0xff2557D2)
                ),
                child: const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text(
                      "Edit Quotation Order",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
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
                                widget.customerFirstName.toString(),
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
                    const SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Consumer<SelectItem>(
              //   builder: (context, item, child) =>
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
                      width: 300,
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
                                      _selectedItemCategory =
                                          value.itemCategory!.id;
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
              // ),
              const SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.only(left: 20, right: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Sales Price"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: TextField(
                            controller: pricecontroller,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Sales Price',
                              hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold),
                              contentPadding: EdgeInsets.all(15),
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
                  ],
                ),
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
                              itemcategory: _selectedItemCategory),
                        );
                      });
                      log(allModelData.length.toString());
                      allModelData.isEmpty
                          ? isVisible = false
                          : isVisible = true;
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
                width: 92,
              ),
              const SizedBox(
                height: 25,
              ),

              FutureBuilder(
                future: quotationServices
                    .fetchQuotationOrderSummaryListFromUrlWithoutCancelled(
                        widget.orderId.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    try {
                      final List<QuotationDetail> newDetail = snapshot.data;
                      return DataTable(
                        columnSpacing: 10,
                        horizontalMargin: 50,
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
                              child: Text('Sale Cost'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Center(child: Text('Action')),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          newDetail.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(newDetail[index].item!.name.toString()),
                              ),
                              DataCell(
                                Text(newDetail[index].saleCost.toString()),
                              ),
                              DataCell(GestureDetector(
                                onTap: () {
                                  setState(() {
                                    newDetail.length > 1
                                        ? OpenCancelDialog(
                                            context, newDetail[index])
                                        : null;
                                    // quotationServices.cancelQuotationFromUrl(quotationOrderSummary.id.toString());
                                  });

                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>EditQuotation()));
                                },
                                child: FaIcon(
                                  newDetail.length > 1
                                      ? FontAwesomeIcons.deleteLeft
                                      : FontAwesomeIcons.ban,
                                  size: 20,
                                  color: Colors.indigo,
                                ),
                              )),
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
              Visibility(
                visible: isVisible,
                child: Column(
                  children: [
                    DataTable(
                      columns: const [
                        DataColumn(label: SizedBox(width: 30, child: Text(""))),
                        DataColumn(label: SizedBox(width: 50, child: Text(""))),
                        DataColumn(label: SizedBox(width: 20, child: Text(""))),
                      ],
                      rows: [
                        for (int i = 0; i < allModelData.length; i++)
                          DataRow(cells: [
                            DataCell(SizedBox(
                                child: Text(
                              "${allModelData[i].name}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ))),
                            DataCell(Text("${allModelData[i].price}")),
                            DataCell(
                              GestureDetector(
                                onTap: () {
                                  for (int i = 0;
                                      i < allModelData.length;
                                      i++) {
                                    setState(() {
                                      allModelData.remove(allModelData[i]);
                                      allModelData.remove(allModelData[i].name);
                                      allModelData
                                          .remove(allModelData[i].price);
                                      allModelData.remove(allModelData[i].id);
                                      allModelData
                                          .remove(allModelData[i].itemcategory);
                                    });
                                  }
                                },
                                child: const FaIcon(
                                  FontAwesomeIcons.deleteLeft,
                                  size: 20,
                                  color: Colors.indigo,
                                ),
                              ),
                            ),
                          ])
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              Container(
                height: 35,
                width: 320,
                //color: Colors.grey,
                padding: const EdgeInsets.only(left: 120, right: 120),
                child: ElevatedButton(
                  onPressed: () async {
                    setState(() {
                      updateQuotation(widget.orderId.toString());

                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const QuotationPage(),
                        ),
                      );
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
              const SizedBox(
                height: 20,
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

  // Future OpenCancelDialog(BuildContext context) => showDialog(
  //   context: context,
  //   builder: (context) => AlertDialog(
  //       title: SizedBox(
  //         width: MediaQuery.of(context).size.width,
  //         child: Column(
  //           children: [
  //
  //             Container(
  //               decoration: const BoxDecoration(),
  //               margin: const EdgeInsets.only(left: 220),
  //               child: GestureDetector(
  //                 child: CircleAvatar(
  //                     radius: 25,
  //                     backgroundColor: Colors.grey.shade100,
  //                     child:
  //                     const Icon(Icons.close, color: Colors.red, size: 20)),
  //                 onTap: () => Navigator.pop(context, true),
  //               ),
  //             ),
  //             Container(child:GestureDetector(
  //                 onTap: ()=> cancelSingleItem(
  //                                               quotationOrderSummary.quotationDetails![i].item!.id.toString(),
  //                                               quotationOrderSummary.quotationDetails![i].item!.itemCategory.toString(),
  //                     quotationOrderSummary.quotationDetails![i].qty.toString(),
  //                     quotationOrderSummary.quotationDetails![i].saleCost.toString(),
  //                                               remarkscontroller.text,
  //                                             orderSummary
  //
  //
  //                                           );,
  //                 child: Text("Yes?")))
  //
  //           ],
  //         ),
  //       )),
  // );
  Future OpenCancelDialog(
          BuildContext context, QuotationDetail quotationDetail) =>
      showDialog(
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
              Container(child: Text("Cancel Order",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),)),
              SizedBox(height: 10,),
              DataTable(
                columnSpacing: 10,
                horizontalMargin: 50,
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
                      child: Text('Sale Cost'),
                    ),
                  ),
                  DataColumn(
                    label: SizedBox(
                      width: 80,
                      child: Text('Qty'),
                    ),
                  ),
                ],
                rows: List.generate(
                  1,
                  (index) => DataRow(
                    // selected: true,
                    cells: [
                      DataCell(
                        Text(quotationDetail.item!.name.toString()),
                      ),
                      DataCell(
                        Text(quotationDetail.saleCost.toString()),
                      ),
                      DataCell(
                        Text(quotationDetail.qty.toString()),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Remarks"),
                  SizedBox(height: 5,),
                  Container(
                    height: 45,
                    width: 200,
                    child: TextField(
                      controller: remarkscontroller,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(color: Colors.white)),
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
              SizedBox(height: 10,),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      cancelSingleItem(
                          quotationDetail.id.toString(),
                          quotationDetail.item!.id.toString(),
                          quotationDetail.item!.itemCategory.toString(),
                          quotationDetail.qty.toString(),
                          quotationDetail.saleCost.toString(),
                          remarkscontroller.text,
                          orderSummary);
                      Navigator.pop(context);
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => EditQuotation(
                      //             customerId: widget.customerId,
                      //             orderId: widget.orderId,
                      //             customerFirstName: widget.customerFirstName)));
                    });

                  },
                  child: Text("Cancel")),
            ],
          ),
        )),
      );

  Future cancelSingleItem(String id, String itemId, String itemCategory,
      String qty, String saleCost, String remarks, List orderSummary) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();


    log('https://$finalUrl/${ApiConstant.cancelItemQuotation + id + 'url'}' );
    // for (int i = 0; i < quotationServices.allQuotation.length; i++) {
    //   orderSummary.add({
    //     "cancelled": true,
    //     "item": id,
    //     "item_category": itemCategory,
    //     "qty": "1.0",
    //     "sale_cost": saleCost,
    //     "remarks": remarkscontroller.text.toString()
    //   });
    // }

    final response = await http.patch(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.cancelItemQuotation + id),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode({
          "cancelled": true,
          "item": itemId,
          "item_category": itemCategory,
          "qty": "1.0",
          "sale_cost": saleCost,
          "remarks": remarkscontroller.text.toString()
        }));

    try {
      log(response.statusCode.toString());
      log(response.body);
      if (response.statusCode == 200) {
        return response.body;
      } else {
        log("${response.body}");
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future updateQuotation(String id) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    log("oredrid::::::::::::" + id);
    var orderQuotation = [];
    for (int i = 0; i < allModelData.length; i++) {
      orderQuotation.add({
        "qty": "1.0",
        "sale_cost": allModelData[i].price,
        "remarks": " ",
        "item": allModelData[i].id,
        "item_category": _selectedItemCategory
      });
    }
    final responeBody = {
      "quotation_details": orderQuotation,
      "customer": widget.customerId,
      "delivery_date_ad": "2022-07-23",
      "remarks": " "
    };
    final response = await http.patch(
        Uri.parse('https://$finalUrl/${ApiConstant.updateQuotation + id}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: (json.encode(responeBody)));

    if (response.statusCode == 201) {
      Notification();
      Fluttertoast.showToast(msg: "Updated Successfully!");
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Response from server :" + response.body.toString());
    }
    log(response.statusCode.toString());
    log("Response from server :" + response.body.toString());
    return response;
  }
}

class OrderSummary {
  Future orderdetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Container(
      child: Text("${prefs.getString("item_name")}"),
    );
  }
}
