
import 'dart:developer';

import 'package:easycare/services/customer_api.dart';
import 'package:flutter/cupertino.dart';
import '../model/byBatch.dart';
import 'model/byBatch.dart';

// class BatchProvider extends ChangeNotifier {
//   List<ByBatchModel> _allBatch = [];
//   List<ByBatchModel> get allBatch => [..._allBatch];
//   Future<void> fetchAllBatch(
//       {required BuildContext context, int? itemId}) async {
//     _allBatch = [];
//     List<ByBatchModel> fetchAllBatchList = [];
//     final result = await CustomerServices.fetchBatchFromUrl(10);
//
// // BatchListModel batchModel = BatchListModel.fromJson(result);
//
//     result['results'].forEach(
//       (element) {
//         fetchAllBatchList.add(
//           ByBatchModel.fromJson(element),
//         );
//       },
//     );
//     _allBatch = fetchAllBatchList;
//     notifyListeners();
//   }
// }
//


class BatchListProvider extends ChangeNotifier {
  List<ByBatchModelProvider> _allBatch = [];
  List<ByBatchModelProvider> get allBatch => [..._allBatch];
  Future<void> fetchAllBatch({ required BuildContext context, int? itemId}) async {
    _allBatch = [];
    List<ByBatchModelProvider> fetchAllBatchList = [];
    final result = await CustomerServices.fetchBatchFromUrl(itemId);
    ByBatchModelProvider batchModel = ByBatchModelProvider.fromJson(result);

    result['results'].forEach(
          (element) {
            fetchAllBatchList.add(
              ByBatchModelProvider.fromJson(element),
        );
      },
    );
    _allBatch = fetchAllBatchList;
    log(_allBatch.toString());
    notifyListeners();
  }
}
