import 'dart:developer';

import 'package:easycare/Constant/apiConstant.dart';
import 'package:easycare/TabPages/homeTabPage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Financial Report/Credit Report/credit_report_page.dart';
import '../Financial Report/CustomerOrderReport/customerOrderReportUi.dart';
import '../Financial Report/Party Report/partyReportScreen.dart';

class StockAnaysisTabPage extends StatefulWidget {
  const StockAnaysisTabPage({Key? key}) : super(key: key);

  @override
  _StockAnaysisTabPageState createState() => _StockAnaysisTabPageState();
}

class _StockAnaysisTabPageState extends State<StockAnaysisTabPage> {

  bool isVisibleCredit = false;
  bool isVisibleParty = false;
   bool? isSuperUser ;
  List<String> permission_code_name = [];
   String username='';

  void initState(){
    setState(() {
      getSuperUser();
      getAllowedFuctions();
      isSuperUser;
      log(permission_code_name.toString());
    });


    super.initState();
  }

  Future<void> getSuperUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
setState(() {
  isSuperUser = pref.getBool("is_super_user") ;
});
    log("final superuser for report"+isSuperUser.toString());
  }
  Future<void> getAllowedFuctions() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {

      if(isSuperUser == false)
        permission_code_name =  pref.getStringList("permission_code_name")! ;
    });
    log("final codes"+permission_code_name.toString());
  }
  Future<void> catchUserName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      username = pref.getString("user_name").toString() ;
    });

    log("codes name"+ pref.getString("user_name").toString());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        'Financial Report',
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
                Container(

                  width: MediaQuery.of(context).size.width,

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
                  child: Padding(
                    padding:
                        const EdgeInsets.only(top: 80.0,left: 20,right: 20),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.only(left:25),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  // GestureDetector(
                                  //   onTap: () =>permission_code_name.contains("view_customer_order_report")||isSuperUser==true? Navigator.push(
                                  //       (context),
                                  //       MaterialPageRoute(
                                  //           builder: (context) =>
                                  //               const CreditReportPage())):Fluttertoast.showToast(msg: "You Don't have permission to view"),
                                  //   child:
                                    Visibility(
                                      visible: permission_code_name.contains("view_customer_order_report")||isSuperUser==true?true:false,
                                      child: GestureDetector(
                                        onTap: () => Navigator.push(
                                                (context),
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const CreditReportPage())),
                                        child: Container(
                                          height: 120,
                                          width: 120,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: const [
                                                Image(image: AssetImage("assets/images/credit.png"),height: 80,),
                                                Text(
                                                  "Credit Report",
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
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Visibility(
                                    visible: permission_code_name.contains("view_customer_order_report")||isSuperUser==true?true:false,
                                    child: GestureDetector(
                                      onTap: () => Navigator.push(
                                              (context),
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const PartyReportPage())),
                                      child: Container(
                                        height: 120,
                                        width: 120,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            children: const [
                                              Image(image: AssetImage("assets/images/payment.png"),height: 80,),
                                              Text(
                                                "Party Report",
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
                                    width: 30,
                                  ),
                                ],
                              ),
                              SizedBox(height: 15,),
                              GestureDetector(
                                onTap: () => permission_code_name.contains("self_customer_order")||isSuperUser == true?
                                Navigator.push(
                                    (context),
                                    MaterialPageRoute(
                                        builder: (context) =>
                                        const CustomerOrderReport())):Fluttertoast.showToast(msg: "You don't have permission to view"),
                                child: Container(
                                  height: 125,
                                  width: 120,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: const [
                                        Image(image: AssetImage("assets/images/selfReport.png"),height: 70,),
                                        Text(
                                          "Customer Order\n         Report",
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
                              const SizedBox(
                                height: 25,
                              ),
                              // Row(
                              //   children: [
                              //     const SizedBox(
                              //       width: 40,
                              //     ),
                              //     GestureDetector(
                              //       // onTap: () => Navigator.push(
                              //       //     (context),
                              //       //     MaterialPageRoute(
                              //       //         builder: (context) =>
                              //       //             const StockAnalysisByLocationPage())),
                              //       child: Container(
                              //         height: 75,
                              //         width: 75,
                              //         child: Padding(
                              //           padding: const EdgeInsets.all(8.0),
                              //           child: Column(
                              //             children: const [
                              //               Icon(
                              //                 Icons.person,
                              //                 color: Color(0xff2C51A4),
                              //                 size: 30,
                              //               ),
                              //               Text(
                              //                 "Analysis",
                              //                 style: TextStyle(
                              //                     fontWeight: FontWeight.bold,
                              //                     fontSize: 12,
                              //                     color: Color(0xff2C51A4)),
                              //               ),
                              //               Text(
                              //                 "Location",
                              //                 style: TextStyle(
                              //                     fontWeight: FontWeight.bold,
                              //                     fontSize: 12,
                              //                     color: Color(0xff2C51A4)),
                              //               ),
                              //             ],
                              //           ),
                              //         ),
                              //         decoration: BoxDecoration(
                              //           color: const Color(0xffeff3ff),
                              //           borderRadius: BorderRadius.circular(10),
                              //           boxShadow: const [
                              //             BoxShadow(
                              //               color: Color(0xffeff3ff),
                              //               offset: Offset(-2, -2),
                              //               spreadRadius: 1,
                              //               blurRadius: 10,
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //     ),
                              //     const SizedBox(
                              //       width: 30,
                              //     ),
                              //     Container(
                              //       height: 75,
                              //       width: 75,
                              //       child: Padding(
                              //         padding: const EdgeInsets.all(8.0),
                              //         child: Column(
                              //           children: const [
                              //             Icon(
                              //               Icons.person,
                              //               color: Color(0xff2C51A4),
                              //               size: 30,
                              //             ),
                              //             Text(
                              //               "Pack",
                              //               style: TextStyle(
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 12,
                              //                   color: Color(0xff2C51A4)),
                              //             ),
                              //             Text(
                              //               "Info",
                              //               style: TextStyle(
                              //                   fontWeight: FontWeight.bold,
                              //                   fontSize: 12,
                              //                   color: Color(0xff2C51A4)),
                              //             ),
                              //           ],
                              //         ),
                              //       ),
                              //       decoration: BoxDecoration(
                              //         color: const Color(0xffeff3ff),
                              //         borderRadius: BorderRadius.circular(10),
                              //         boxShadow: const [
                              //           BoxShadow(
                              //             color: Color(0xffeff3ff),
                              //             offset: Offset(-2, -2),
                              //             spreadRadius: 1,
                              //             blurRadius: 10,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 25,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Container(
                //   padding: const EdgeInsets.all(30),
                //   child: Column(
                //     children: [
                //       Row(
                //         children: [
                //           GestureDetector(
                //             onTap:()=>Navigator.push((context), MaterialPageRoute(builder: (contetx)=>const StockAnaysisTabPage())),
                //             child: Container(
                //               height: 75,
                //               width: 75,
                //               child: const Padding(
                //                 padding: EdgeInsets.only(top:20,left: 10),
                //                 child: Text("Customer Order"
                //                 , style:  TextStyle(fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey.shade300,
                //                 borderRadius: BorderRadius.circular(22),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.grey.shade500,
                //                     offset: const Offset(-4,-4),
                //                     spreadRadius: 1,
                //                     blurRadius: 10,
                //
                //                   ),
                //                 ],
                //               ),
                //
                //             ),
                //           ),
                //                const SizedBox(width: 30,),
                //
                //
                //                   Badge(
                //                    badgeContent: Text(
                //                        "$_counter"
                //                        ),
                //                    child: Container(
                //                      height: 75,
                //                      width: 75,
                //                      child: const Padding(
                //                        padding: EdgeInsets.only(top:15,left: 10),
                //                        child:  Text("Customer Order Verified"
                //                          , style: TextStyle(fontWeight: FontWeight.bold),
                //                        ),
                //                      ),
                //                      decoration: BoxDecoration(
                //                        color: Colors.grey.shade300,
                //                        borderRadius: BorderRadius.circular(22),
                //                        boxShadow: [
                //                          BoxShadow(
                //                              color: Colors.grey.shade500,
                //                              offset: const Offset(-4,-4),
                //                              spreadRadius: 1,
                //                            blurRadius: 10,
                //
                //                          ),
                //                        ],
                //                      ),
                //
                //                    ),
                //
                //                  ),
                //
                //
                //           const SizedBox(width: 30,),
                //           Badge(
                //             badgeContent: Text(
                //                 "$_counter"
                //             ),
                //             child: Container(
                //               height: 75,
                //               width: 75,
                //               child: const Padding(
                //                 padding: EdgeInsets.only(top:20,left: 10),
                //                 child: const Text("Pending Order"
                //                   , style: const TextStyle(fontWeight: FontWeight.bold),
                //                 ),
                //               ),
                //               decoration: BoxDecoration(
                //                 color: Colors.grey.shade300,
                //                 borderRadius: BorderRadius.circular(22),
                //                 boxShadow: [
                //                   BoxShadow(
                //                     color: Colors.grey.shade500,
                //                     offset: const Offset(-4,-4),
                //                     spreadRadius: 1,
                //                     blurRadius: 10,
                //
                //                   ),
                //                 ],
                //               ),
                //
                //             ),
                //           ),
                //         ],
                //
                //       ),
                //       const SizedBox(height: 25,),
                //       Row(
                //         children: [
                //           Container(
                //             height: 75,
                //             width: 75,
                //             child: const Padding(
                //               padding: EdgeInsets.only(top:20,left: 10),
                //               child: const Text("Xyz"
                //                 , style: TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade300,
                //               borderRadius: BorderRadius.circular(22),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.shade500,
                //                   offset: const Offset(-4,-4),
                //                   spreadRadius: 1,
                //                   blurRadius: 10,
                //
                //                 ),
                //               ],
                //             ),
                //
                //           ),
                //           const SizedBox(width: 30,),
                //           Container(
                //             height: 75,
                //             width: 75,
                //             child: const Padding(
                //               padding: EdgeInsets.only(top:20,left: 10),
                //               child: Text("ABC"
                //                 , style: TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade300,
                //               borderRadius: BorderRadius.circular(22),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.shade500,
                //                   offset: const Offset(-4,-4),
                //                   spreadRadius: 1,
                //                   blurRadius: 10,
                //
                //                 ),
                //               ],
                //             ),
                //
                //           ),
                //           const SizedBox(width: 30,),
                //           Container(
                //             height: 75,
                //             width: 75,
                //             child: const Padding(
                //               padding: EdgeInsets.only(top:20,left: 10),
                //               child: const Text("xYZ"
                //                 , style: TextStyle(fontWeight: FontWeight.bold),
                //               ),
                //             ),
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade300,
                //               borderRadius: BorderRadius.circular(22),
                //               boxShadow: [
                //                 BoxShadow(
                //                   color: Colors.grey.shade500,
                //                   offset: const Offset(-4,-4),
                //                   spreadRadius: 1,
                //                   blurRadius: 10,
                //
                //                 ),
                //               ],
                //             ),
                //
                //           ),
                //         ],
                //
                //       ),
                //
                //     ],
                //   ),
                // ),
                // Container(
                //   height: 200,
                //   width: MediaQuery.of(context).size.width,
                //   child: Padding(
                //     padding: const EdgeInsets.all(.0),
                //     child: Table(
                //       columnWidths: {
                //         0 : FlexColumnWidth(3),
                //         1 : FlexColumnWidth(1),
                //       },
                //       border: TableBorder(horizontalInside: BorderSide(width: 1,color: Colors.grey.withOpacity(0.5),style: BorderStyle.solid,)
                //       ),
                //       children: [
                //         TableRow(
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade400.withOpacity(0.4),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             children :[
                //
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('Verified Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('2',style: TextStyle(fontWeight: FontWeight.bold)),
                //               ),
                //
                //
                //             ]),
                //         TableRow(
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade400.withOpacity(0.4),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             children :[
                //
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('Pending Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('5',style: TextStyle(fontWeight: FontWeight.bold)),
                //               ),
                //
                //
                //             ]),
                //         TableRow(
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade400.withOpacity(0.4),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             children :[
                //
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('Verified Order',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('2',style: TextStyle(fontWeight: FontWeight.bold)),
                //               ),
                //
                //
                //             ]),
                //         TableRow(
                //             decoration: BoxDecoration(
                //               color: Colors.grey.shade400.withOpacity(0.4),
                //               borderRadius: BorderRadius.circular(10),
                //             ),
                //             children :[
                //
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('Pending Orders',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),),
                //               ),
                //               Padding(
                //                 padding: EdgeInsets.all(8.0),
                //                 child: Text('5',style: TextStyle(fontWeight: FontWeight.bold)),
                //               ),
                //
                //
                //             ]),
                //       ],
                //     ),
                //   ),
                //   decoration: BoxDecoration(
                //     color: Colors.grey.shade300,
                //     borderRadius: BorderRadius.circular(22),
                //     boxShadow: [
                //       BoxShadow(
                //         color: Colors.grey.shade500,
                //         offset: Offset(-4,-4),
                //         spreadRadius: 1,
                //         blurRadius: 10,
                //
                //       ),
                //     ],
                //   ),
                //
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
