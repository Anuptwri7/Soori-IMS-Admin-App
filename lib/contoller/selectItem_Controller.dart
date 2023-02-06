import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';

import '../model/customer.dart';
import '../service/customer_api.dart';

class SelectItem extends ChangeNotifier {
  List<ItemModal> item = [];
  CustomerServices customerServices = CustomerServices();
  UnmodifiableListView<ItemModal> get items => UnmodifiableListView(item);
  // final i = SelectItem();

  Future fetchItems() async {
    try {
      // await Future.delayed(const Duration(seconds: 5));
      List<ItemModal> apiItems = await customerServices.fetchItemsFromUrl();
      item = apiItems;
      log(item.length.toString());
    } catch (e) {
      throw Exception(e);
    }
    notifyListeners();
  }
}
