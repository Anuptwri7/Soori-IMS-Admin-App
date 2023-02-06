import 'dart:convert';
import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

class Edit extends StatefulWidget {
  final int? customerId;
  final int? userId;
  final String userName;

  const Edit(
      {Key? key,
      required this.customerId,
      required this.userId,
      required this.userName})
      : super(key: key);

  @override
  _EditState createState() => _EditState();
}

class _EditState extends State<Edit> {
  String? _selectedCustomer;
  String? _selectedCustomerName;
  int? _selectedItem;
  String? _selectedItemName;
  bool isVisible = false;
  TextEditingController remarkscontroller = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController discountPercentageController = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController qtyController = TextEditingController();
  List<AddItemModel> allModelData = [];

  ListingServices listingservices = ListingServices();

  Future CancelSingleOrder(String cancelId) async {
    return await listingservices.CancelSingleOrderFromUrl(cancelId);
  }

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

  @override
  Widget build(BuildContext context) {
    // final item = Provider.of<SelectItem>(context);
    //   log(widget.userId);
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
                      "Edit Customer Order",
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
                                widget.userName.toString(),
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
                        future: customerServices.fetchItemsFromUrl(),
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
                              final List<ItemModal> snapshotData =
                                  snapshot.data;
                              customerServices.allItems = [];
                              return SearchChoices.single(
                                items: snapshotData.map((ItemModal value) {
                                  return (DropdownMenuItem(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, top: 5.0),
                                      child: Text(
                                        value.name.toString() +
                                            "||" +
                                            value.remaining_qty.toString(),
                                        style: const TextStyle(fontSize: 15),
                                      ),
                                    ),
                                    value: value.name.toString(),
                                    onTap: () {
                                      // setState(() {
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
                                onChanged: (ItemModal? value) {},
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
                    const SizedBox(
                      width: 15,
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
                          width: 165,
                          child: TextField(
                            controller: locationController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
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
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18, right: 10),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Quantity"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: TextField(
                            controller: qtyController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                              fillColor: Colors.white,
                              hintText: 'Quantity',
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
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Delivery Date"),
                        const SizedBox(
                          height: 8,
                        ),
                        Container(
                          height: 45,
                          width: 165,
                          child: InkWell(
                            onTap: () {
                              _pickDateDialog();
                            },
                            child: TextField(
                              controller: dateController,
                              enabled: false,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: 'Delivery Date',
                                border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0)),
                                  borderSide: BorderSide(color: Colors.white)),
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
                    const SizedBox(
                      width: 15,
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
                      if (pricecontroller.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the price");
                      }
                      if (qtyController.text.isEmpty) {
                        Fluttertoast.showToast(msg: "Enter the Quantity");
                      }
                      if (discountPercentageController.text.isEmpty) {
                        Fluttertoast.showToast(
                            msg: "Enter the Discount if not keep it 0");
                      } else {
                        setState(() {
                          //   allModelData.clear();
                          allModelData.add(
                            AddItemModel(
                              id: _selectedItem,
                              name: _selectedItemName.toString(),
                              quantity: double.parse(qtyController.text),
                              price: double.parse(pricecontroller.text),
                              discount: double.parse(
                                  discountPercentageController.text),
                              discountAmt: (double.parse(
                                      discountPercentageController.text) *
                                  (double.parse(pricecontroller.text) *
                                      int.parse(qtyController.text)) /
                                  100),
                              amount: double.parse(pricecontroller.text) *
                                  int.parse(qtyController.text),
                              totalAfterDiscount: (double.parse(
                                          pricecontroller.text) *
                                      int.parse(qtyController.text) -
                                  (double.parse(
                                          discountPercentageController.text) *
                                      (double.parse(pricecontroller.text) *
                                          int.parse(qtyController.text)) /
                                      100)),
                            ),
                          );
                          _selectedItemName = "";
                          log('allModelData.length : ' +
                              allModelData.length.toString());
                        });
                      }
                      allModelData.isEmpty
                          ? isVisible = false
                          : isVisible = true;

                      qtyController.clear();
                      pricecontroller.clear();
                      discountPercentageController.clear();
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
                future: listingservices
                    .fetchOrderSummaryListFromUrl(widget.userId.toString()),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    try {
                      final snapshotData = json.decode(snapshot.data);

                      OrderSummaryList orderSummaryList =
                          OrderSummaryList.fromJson(snapshotData);

                      return DataTable(
                        columnSpacing: 10,
                        horizontalMargin: 0,
                        // columnSpacing: 10,
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
                              child: Text('Quantity'),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 80,
                              child: Center(child: Text('Amount')),
                            ),
                          ),
                          DataColumn(
                            label: SizedBox(
                              width: 60,
                              child: Text('Discount'),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          orderSummaryList.orderDetails!.length,
                          (index) => DataRow(
                            // selected: true,
                            cells: [
                              DataCell(
                                Text(orderSummaryList
                                    .orderDetails![index].item!.name
                                    .toString()),
                              ),
                              DataCell(
                                Text(orderSummaryList.orderDetails![index].qty
                                    .toString()),
                              ),
                              DataCell(
                                Text(orderSummaryList
                                    .orderDetails![index].saleCost
                                    .toString()),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(orderSummaryList
                                      .orderDetails![index].discountAmount
                                      .toString()),
                                ),
                              ),
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
                        DataColumn(label: SizedBox(width: 50, child: Text(""))),
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
                            DataCell(Text("${allModelData[i].quantity}")),
                            DataCell(Text("${allModelData[i].amount}")),
                            DataCell(Text("${allModelData[i].discountAmt}")),
                          ])
                      ],
                    ),
                    const SizedBox(
                      height: 20,
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
                      UpdateProduct(widget.userId);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MoreTabPage(),
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

  Future UpdateProduct(int? updateId) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    String finalUrl = sharedPreferences.getString("subDomain").toString();

    double grandTotal = 0.0,
        subTotal = 0.0,
        totalDiscount = 0.0,
        finaldiscount = 0.0,
        x = 0.0;
    var orderDetails = [];
    for (int i = 0; i < allModelData.length; i++) {
      // log("total discount"+totalDiscount.toString());
      subTotal += allModelData[i].amount!;
      totalDiscount +=
          (allModelData[i].discount! * allModelData[i].amount!) / 100;
      finaldiscount = (subTotal - totalDiscount);
      log("gjhgj" + finaldiscount.toString());
      grandTotal += (finaldiscount - allModelData[i].amount!);
      x += allModelData[i].totalAfterDiscount!;
      log("grand toral hjgjhghjgjgh" + x.toString());
      orderDetails.add({
        "item": allModelData[i].id,
        "item_category": 8,
        "taxable": "false",
        "discountable": "true",
        "qty": allModelData[i].quantity,
        "purchase_cost": 0,
        "sale_cost": allModelData[i].price,
        "discount_rate": allModelData[i].discount,
        "discount_amount": allModelData[i].discountAmt,
        "tax_rate": 0,
        "tax_amount": 0,
        "gross_amount": allModelData[i].amount,
        "net_amount": allModelData[i].totalAfterDiscount,
        "remarks": "",
        "isNew": "true",
        "unique": "2ed54673-a7b4-489f-91a2-98abe79241ee",
        "cancelled": "false"
      });
    }
    log("widgets" + widget.userId.toString());

    final responseBody = {
      "status": 1,
      "customer": widget.customerId,
      "sub_total": subTotal,
      "total_discount": totalDiscount,
      "total_tax": 0,
      "grand_total": x,
      "remarks": "",
      "total_discountable_amount": subTotal,
      "total_taxable_amount": 0,
      "total_non_taxable_amount": x,
      "discount_scheme": '',
      "discount_rate": 0,
      "delivery_location": locationController.text,
      "delivery_date_ad": dateController.text,
      "order_details": orderDetails,
    };
    log(json.encode(responseBody));
    final response = await http.patch(
        Uri.parse(
            'https://$finalUrl/${ApiConstant.editCustomerOrder + updateId.toString()}'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        },
        body: json.encode(responseBody));
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Product Added Successfully");

      qtyController.clear();
      pricecontroller.clear();
      discountPercentageController.clear();
      // DataCell.empty;
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
          msg: "Response from server :" + response.body.toString());
    }
    log(response.statusCode.toString());
    log("Response from server :" + response.body.toString());
    return response;
  }
}
