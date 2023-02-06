
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:easycare/model/lineModel.dart';
import "package:http/http.dart" as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../Constant/apiConstant.dart';

class LineChartServices {
  List<int> allDate = [];
  List<num> finalData = [];
  List<double> purchase = [];
  List<double> sale = [];
  Map<int,double> dict={};

  Future fetchLineChartFromUrl() async {
    final SharedPreferences sharedPreferences =
    await SharedPreferences.getInstance();
    final response = await http.get(
        Uri.parse(ApiConstant.baseUrl + ApiConstant.lineChart),
        headers: {
          'Content-type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
        });

    log(response.body);

    try {
      if (response.statusCode == 200) {
        for(int i = 0 ; i<json.decode(response.body)['date'].length;i++){
          allDate.add(
            json.decode(response.body)['date'][i]
          );
          log("hjgj"+allDate.toString());


        }
        for(int i = 0 ; i<json.decode(response.body)['purchase_amount'].length;i++){
          purchase.add(
              json.decode(response.body)['purchase_amount'][i]
          );
      log("purchase"+purchase.toString());

        }
        for(int i = 0 ; i<json.decode(response.body)['sale_amount'].length;i++){
          sale.add(
              json.decode(response.body)['sale_amount'][i]
          );
         log("sales chart"+sale.toString());

        }

            finalData.addAll(allDate);
            finalData.addAll(purchase);
            finalData.addAll(sale);
            log("kj"+finalData.toString());

        log("kj"+finalData.toString());
        dict = Map.fromIterables(allDate,purchase);
        log("message"+dict.toString());

        return dict;


      }
    } catch (e) {

      throw Exception(e);
    }
  }

}
