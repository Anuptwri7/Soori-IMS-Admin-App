import 'dart:developer';

import 'package:easycare/Notification/model/notificationCount.dart';
import 'package:easycare/TabPages/quotationPage.dart';
import 'package:easycare/TabPages/testNotification.dart';
import 'package:easycare/stock%20management/stock_anaysis.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Credit Managament/credit_clearance.dart';
import '../Notification/controller/notificationController.dart';
import '../Notification/notificationScreen.dart';
import '../Party Pament/party_payment.dart';
import 'AddCustomerOrder.dart';
import 'customerListings.dart';
import 'customerOrderList.dart';
List<String> permission_code_name = [];
bool? isSuperUser ;

class HomeTabPage extends StatefulWidget {

  const HomeTabPage({Key? key}) : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState extends State<HomeTabPage> {
  int numNotific = 10;
  bool isVisibleCreateOrder = false;
  bool isVisibleCustomerOrder =false;
  bool isVisibleCustomerList = false;
  bool isVisiblePartyPayment = false;
  bool isVisibleCreditClearance= false;
  bool isVisibleStockAnalysis = false;
  bool? isSuperUser ;
  String username='';
  List<String> permission_code_name = [];
  @override
  void initState() {
    getSuperUser();
    catchUserName();
    getAllowedFuctions();
    super.initState();
    final data = Provider.of<NotificationClass>(context, listen: false);
    data.fetchCount(context);
  }
  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();

      isSuperUser =  pref.getBool("is_super_user") ;
    log("final superuser"+isSuperUser.toString());
  }

  @override
  Widget build(BuildContext context) {
    final count = Provider.of<NotificationClass>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          // const Icon(
          //   Icons.search,
          //   color: Color(0xff2c51a4),
          // ),
          const SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NotificationPage()));
            },
            child: Stack(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications,
                    color: Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationPage()));
                  },
                ),
                if (count.notificationCountModel?.unreadCount != null)
                  Positioned(
                    right: 11,
                    top: 11,
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 14,
                        minHeight: 14,
                      ),
                      child: Text(
                        "${(count.notificationCountModel?.unreadCount)! > (numNotific) ?"9+":count.notificationCountModel?.unreadCount}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  )
                else
                  Container()
              ],
            ),
          ),
          const SizedBox(
            width: 15,
          ),
        ],
        leading: const Icon(
          Icons.person,
          color: Color(0xff2c51a4),
        ),
        title: Text(
         username.isNotEmpty? username.toUpperCase():"Loading...",
          style: TextStyle(color: Colors.blueGrey, fontSize: 15,fontWeight: FontWeight.bold),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  height: 120,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment(-1.0, -0.94),
                        end: Alignment(0.968, 1.0),
                        colors: [Color(0xff2c51a4), Color(0xff6b88e8)],
                        stops: [0.0, 1.0],
                      ),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(100.0),
                        topRight: Radius.circular(5.0),
                        bottomRight: Radius.circular(5.0),
                        bottomLeft: Radius.circular(5.0),
                      ),
                      color: Colors.blue),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 200.0),
                      child: Text(
                        'Soori IMS',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
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
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 450,

                  decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x155665df),
                        spreadRadius: 5,
                        blurRadius: 17,
                        offset: Offset(0, 3),
                      )
                    ],
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                    color: Colors.white,
                  ),
                  child: Row(
                    children: [

                      Container(
                        padding: const EdgeInsets.only(left: 30,right: 10,top: 20),
                        child: Column(
                          children: [

                            Row(
                              children: [
                                Visibility(
                                  visible: permission_code_name.contains("add_customer_order")||isSuperUser == true ?true:isVisibleCreateOrder,
                                  child: GestureDetector(
                                    onTap: () =>   OpenDialogCustomer(context),
                                        // Navigator.push(
                                        // (context),
                                        // MaterialPageRoute(
                                        //     builder: (context) =>
                                        //
                                                // const AddPropertyTabPage()
                                        // )),
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: const [
                                            Image(image: AssetImage("assets/images/create.png"),height: 80,),
                                            SizedBox(height: 5,),
                                            Text(
                                              "Customer Order",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xff2C51A4)),
                                            ),

                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffeff3ff),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffeff3ff),
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),

                                Visibility(
                                  visible: permission_code_name.contains("view_customer_order")||permission_code_name.contains("self_customer_order")||isSuperUser == true?true:isVisibleCustomerOrder,
                                  child: GestureDetector(
                                    onTap: () => {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const CustomerOrderListScreen()),

                                      ),

                                    },



                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: const [
                                            Image(image: AssetImage("assets/images/order.png"),height: 80,),
                                            SizedBox(height: 5,),
                                            Text(
                                              "View Orders",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xff2C51A4)),
                                            ),

                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffeff3ff),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffeff3ff),
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // ),



                                // ),
                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: permission_code_name.contains("view_party_payment")
                                      || permission_code_name.contains("add_party_payment")||isSuperUser == true?
                                  true:
                                  isVisiblePartyPayment,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const PartyPayment()));
                                    },
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: const [
                                            Image(image: AssetImage("assets/images/payment.png"),height: 80,),
                                            SizedBox(height: 5,),
                                            Text(
                                              "Party Payment",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xff2C51A4)),
                                            ),

                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffEFF3FF),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffeff3ff),
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                Visibility(
                                  visible: permission_code_name.contains("view_credit_clearance")||
                                      permission_code_name.contains("add_credit_clearance")||isSuperUser == true? true:
                                      isVisibleCreditClearance,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CreditClearance()));
                                    },
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: const [

                                            Image(image: AssetImage("assets/images/credit.png"),height: 80,),
                                            SizedBox(height: 5,),
                                            Text(
                                              "Credit Clearance",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xff2C51A4)),
                                            ),

                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffeff3ff),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffeff3ff),
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),

                              ],
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Row(
                              children: [
                                Visibility(
                                  visible: permission_code_name.contains("view_customer")||isSuperUser == true ?true:isVisibleCreateOrder,
                                  child: GestureDetector(
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                            const CustomerListings())),
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: const [
                                            Image(image: AssetImage("assets/images/person.png"),height: 80,),

                                            Text(
                                              "Customer List",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xff2C51A4)),
                                            ),

                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffeff3ff),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffeff3ff),
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 40,
                                ),

                                Visibility(
                                  visible: permission_code_name.contains("view_stock_analysis")||isSuperUser == true?true:isVisibleCustomerOrder,
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                              const StockAnalysisPage()));
                                    },
                                    child: Container(
                                      height: 120,
                                      width: MediaQuery.of(context).size.width/3,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: const [
                                            Image(image: AssetImage("assets/images/stock.png"),height: 80,),
                                            Text(
                                              "Stock Analysis",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 12,
                                                  color: Color(0xff2C51A4)),
                                            ),

                                          ],
                                        ),
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffeff3ff),
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0xffeff3ff),
                                            offset: Offset(-2, -2),
                                            spreadRadius: 1,
                                            blurRadius: 10,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                // ),



                                // ),
                              ],
                            ),
                            // InkWell(
                            //   // onTap: () {
                            //   //   Navigator.push(
                            //   //       context,
                            //   //       MaterialPageRoute(
                            //   //           builder: (context) =>
                            //   //               const CreditReport()));
                            //   // },
                            //   onTap: () async {
                            //
                            //   },
                            //   child: Container(
                            //     height: 40,
                            //     width: 105,
                            //     child: const Padding(
                            //       padding: EdgeInsets.all(8),
                            //       child: Center(
                            //         child: Text(
                            //           "View More",
                            //           style:
                            //               TextStyle(color: Color(0xff2C51A4)),
                            //         ),
                            //       ),
                            //     ),
                            //     decoration: BoxDecoration(
                            //       color: Colors.white,
                            //       borderRadius: BorderRadius.circular(20),
                            //       boxShadow: const [
                            //         BoxShadow(
                            //           color: Color(0xffeff3ff),
                            //           offset: Offset(5, 8),
                            //           spreadRadius: 5,
                            //           blurRadius: 12,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );

  }
  Future<void> catchUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    username = pref.getString("user_name").toString() ;
    log("codes name"+ pref.getString("user_name").toString());
  }
  Future<void> getAllowedFuctions() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    if(isSuperUser == false)
    permission_code_name =  pref.getStringList("permission_code_name")! ;
    log("final codes"+permission_code_name.toString());
  }
  Future OpenDialogCustomer(BuildContext context) => showDialog(
    context: context,
    builder: (context) => AlertDialog(
        title: SizedBox(

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
              Container(child: Text("Select one to Proceed")),
      SizedBox(height: 10,),
      Padding(
        padding: const EdgeInsets.only(bottom:10.0),
        child: Container(

          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0x155665df),
                spreadRadius: 5,
                blurRadius: 17,
                offset: Offset(0, 3),
              )
            ],
            borderRadius: BorderRadius.all(
              Radius.circular(18.0),
            ),
            color: Colors.white,
          ),
        child: Center(
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(width: 30,),
                  Visibility(
                    visible: permission_code_name.contains("view_quotation")||isSuperUser == true?true:isVisibleCustomerOrder,
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const QuotationPage()),
                        ),
                      },
                      child: Container(
                        height: 80,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: const [
                              Image(image: AssetImage("assets/images/quotation.png"),height: 40,),
                              SizedBox(height: 5,),
                              Text(
                                "Quotation",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color(0xff2C51A4)),
                              ),

                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffeff3ff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffeff3ff),
                              offset: Offset(-2, -2),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: permission_code_name.contains("add_customer_order")||isSuperUser == true?true:isVisibleCustomerOrder,
                    child: GestureDetector(
                      onTap: () => {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                              const AddPropertyTabPage()),
                        ),
                      },



                      child: Container(
                        height: 80,
                        width: 100,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: const [
                              Image(image: AssetImage("assets/images/create.png"),height: 40,),
                              SizedBox(height: 5,),
                              Text(
                                "Create Order",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: Color(0xff2C51A4)),
                              ),

                            ],
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xffeff3ff),
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0xffeff3ff),
                              offset: Offset(-2, -2),
                              spreadRadius: 1,
                              blurRadius: 10,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),),
      )



            ],
          ),
        )),
  );

}
