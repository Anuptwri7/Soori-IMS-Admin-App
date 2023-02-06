import 'dart:developer';

import 'package:easycare/service/customer_api.dart';
import 'package:flutter/material.dart';
import 'package:search_choices/search_choices.dart';
import 'package:shimmer/shimmer.dart';

import '../model/customer.dart';

class ByBatch extends StatefulWidget {
  const ByBatch({Key? key}) : super(key: key);

  @override
  _ByBatchState createState() => _ByBatchState();
}

class _ByBatchState extends State<ByBatch> {

  CustomerServices customerServices = CustomerServices();
  DateTime? picked;
  bool isChecked = false;
  String? _selectedCustomer;
  String? _selectedCustomerName;
  int? _selectedItem;
  bool? _taxable;
  bool? loading = false;
  String? _taxRate;
  String? _selectedItemName;
  double? _remainingQty;
  int selectedId = 0;
  String discountInitial = "10.00";
  int discountId = 0;
  int itemId = 0;
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
              future: customerServices.fetchItemsFromUrl(),
              builder: (BuildContext context,
                  AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  try {
                    final List<ItemModal> snapshotData =
                        snapshot.data;
                    // customerServices.allItems = [];
                    return SearchChoices.single(
                      items:
                      snapshotData.map((ItemModal value) {
                        return (DropdownMenuItem(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10, top: 5.0),
                            child: Text(
                              "${value.name} || Remaining Qty: ${value.remaining_qty}",
                              style: const TextStyle(
                                  fontSize: 14),
                            ),
                          ),
                          value: value.name.toString(),
                          onTap: () {
                            // setState(() {
                            _selectedItem = value.id;
                            _selectedItemName = value.name;
                            _taxable = value.taxable;
                            _taxRate =
                                value.tax_rate.toString();
                            _remainingQty = double.parse(
                                "${value.remaining_qty}");
                            log('selected item is Taxable or not : ${_taxable.toString()}');
                            log('selected item taxRate : ${_taxRate.toString()}');
                            log('selected item name : ${_selectedItemName.toString()}');
                            log('selected item name : ${_selectedItem.toString()}');

                            // });
                          },
                        ));
                      }).toList(),
                      value: _selectedItemName.toString(),
                      clearIcon: const Icon(
                        Icons.close,
                        size: 0,
                      ),
                      icon: const Visibility(
                        visible: false,
                        child: Icon(Icons.arrow_downward),
                      ),
                      underline: DropdownButtonHideUnderline(
                          child: Container()),
                      padding: 0,
                      hint: const Padding(
                        padding:
                        EdgeInsets.only(top: 15, left: 8),
                        child: Text(
                          "Select Item",
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      searchHint: "Select Item",
                      onChanged: (ItemModal? value) {},
                      dialogBox: true,
                      keyboardType: TextInputType.text,
                      isExpanded: true,
                    );
                  } catch (e) {
                    throw Exception(e);
                  }
                } else {
                  return Opacity(
                    opacity: 0.8,
                    child: Shimmer.fromColors(
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                              'Loading Items .....',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black)),
                        ),
                        baseColor: Colors.black12,
                        highlightColor: Colors.white),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
