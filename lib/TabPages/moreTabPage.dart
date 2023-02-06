import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../model/customer_order_list.dart';
import '../service/listingServices.dart';
import '../widget/edit.dart';
import '../widget/view_details.dart';

class MoreTabPage extends StatefulWidget {
  const MoreTabPage({Key? key}) : super(key: key);

  @override
  State<MoreTabPage> createState() => _MoreTabPageState();
}

class _MoreTabPageState extends State<MoreTabPage> {
  // String get $i => null;
  ListingServices listingservices = ListingServices();
  final TextEditingController _searchController = TextEditingController();
  static String _searchItem = '';

  Future searchHandling() async {
    // await Future.delayed(const Duration(seconds: 3));
    log(" SEARCH ${_searchController.text}");
    if (_searchItem == "") {
      return await listingservices.fetchOrderListFromUrl('');
    } else {
      return await listingservices.fetchOrderListFromUrl(_searchItem);
    }
  }

  Future CancelOrder(String cancelId) async {
    return await listingservices.cancelOrderFromUrl(cancelId);
  }

  @override
  void initState() {
    // searchHandling();
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
          padding: const EdgeInsets.only(top:350.0),
          child: Column(
            children: [
              Center(child: Image(image: AssetImage("assets/images/logo.png")))
            ],
          ),
        ),
      ),
    );
  }
}
