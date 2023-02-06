// import 'dart:convert';
// import 'dart:developer';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import '../Constant/ApiConstant.dart';
// import 'addModel.dart';
//
//
// TextEditingController firstName = TextEditingController();
// TextEditingController discountName = TextEditingController();
// TextEditingController discountRate = TextEditingController();
// TextEditingController middleName = TextEditingController();
// TextEditingController lastName = TextEditingController();
// TextEditingController address = TextEditingController();
// TextEditingController contactNumber = TextEditingController();
// TextEditingController PanNumber = TextEditingController();
// ScrollController scrollController = ScrollController();
//
// class EditCustomerPage extends StatefulWidget {
//   String ?name;
//   String? phone;
//   String ?address;
//   String? pan;
//
//    EditCustomerPage({Key? key,required this.name,required this.address,required this.phone, required this.pan}) : super(key: key);
//
//   @override
//   _EditCustomerPageState createState() => _EditCustomerPageState();
// }
//
// class _EditCustomerPageState extends State<EditCustomerPage> {
//
//
//
//   TextEditingController remarkscontroller = TextEditingController();
//   TextEditingController dateController = TextEditingController();
//   TextEditingController locationController = TextEditingController();
//   TextEditingController discountPercentageController = TextEditingController();
//   TextEditingController pricecontroller = TextEditingController();
//   TextEditingController qtyController = TextEditingController();
//   List<AddItemModel> allModelData = [];
//   bool isVisibleAddCustomer=false;
//   List<String> permission_code_name = [];
//   // List<ItemModal> allitemData = [];
//
//
//
//
//   @override
//   void setState(VoidCallback fn) {
//
//     // TODO: implement setState
//     super.setState(fn);
//
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//
//   @override
//   void initState() {
//
//
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Color getColor(Set<MaterialState> states) {
//       const Set<MaterialState> interactiveStates = <MaterialState>{
//         MaterialState.pressed,
//         MaterialState.hovered,
//         MaterialState.focused,
//       };
//       if (states.any(interactiveStates.contains)) {
//         return Colors.blue;
//       }
//       return Colors.black;
//     }
//
//     return Scaffold(
//
//       backgroundColor: const Color(0xffeff3ff),
//       body: SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Padding(
//           padding: const EdgeInsets.all(0.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 height: 150,
//                 decoration: const BoxDecoration(
//                   gradient: LinearGradient(
//                     begin: Alignment(-1.0, -0.94),
//                     end: Alignment(0.968, 1.0),
//                     colors: [Color(0xff2557D2), Color(0xff6b88e8)],
//                     stops: [0.0, 1.0],
//                   ),
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(0.0),
//                     topRight: Radius.circular(0.0),
//                     bottomRight: Radius.circular(10.0),
//                     bottomLeft: Radius.circular(10.0),
//                   ),
//                   //   color: Color(0xff2557D2)
//                 ),
//                 child: const Padding(
//                   padding: EdgeInsets.only(top: 20),
//                   child: Center(
//                     child: Text(
//                       'Create Customer Order',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.grey.shade300,
//                 child: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(left: 100.0),
//                       child: Container(
//                         child:const Text(
//                           "FIFO Wise:",
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 15),
//                         ),
//                       ),
//                     ),
//
//                   ],
//                 ),
//               ),
//
//               Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xfff5f7ff),
//                   borderRadius: BorderRadius.circular(20),
//                   boxShadow: const [
//                     BoxShadow(
//                       color: Color(0xfff5f7ff),
//                       offset: Offset(5, 8),
//                       spreadRadius: 5,
//                       blurRadius: 12,
//                     ),
//                   ],
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Padding(
//                         padding: const EdgeInsets.only(left: 20),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           // crossAxisAlignment: CrossAxisAlignment.stretch,
//                           children: [
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     const Text("First Name"),
//                                     const SizedBox(
//                                       height: 8,
//                                     ),
//                                     Container(
//                                       height: 45,
//                                       width: MediaQuery.of(context).size.width/4,
//                                       child: TextField(
//                                         controller: locationController,
//                                         keyboardType: TextInputType.text,
//                                         decoration: const InputDecoration(
//                                           border: OutlineInputBorder(
//                                               borderRadius: BorderRadius.all(
//                                                   Radius.circular(10.0)),
//                                               borderSide:
//                                               BorderSide(color: Colors.white)),
//                                           filled: true,
//                                           fillColor: Colors.white,
//                                           hintText: '${widget.name.toString()}',
//                                           hintStyle: TextStyle(
//                                               fontSize: 14,
//                                               color: Colors.grey,
//                                               fontWeight: FontWeight.bold),
//                                           contentPadding: EdgeInsets.all(15),
//                                         ),
//                                       ),
//                                       decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius: BorderRadius.circular(15),
//                                           boxShadow: const [
//                                             BoxShadow(
//                                               color: Colors.grey,
//                                               spreadRadius: 1,
//                                               blurRadius: 2,
//                                               offset: Offset(4, 4),
//                                             )
//                                           ]),
//                                     ),
//                                   ],
//                                 ),
//
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//
//
//                       const SizedBox(
//                         height: 20,
//                       ),
//
//
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 10),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text("Delivery Location"),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 Container(
//                                   height: 45,
//                                   width: MediaQuery.of(context).size.width/4,
//                                   child: TextField(
//                                     controller: locationController,
//                                     keyboardType: TextInputType.text,
//                                     decoration: const InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10.0)),
//                                           borderSide:
//                                           BorderSide(color: Colors.white)),
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       hintText: 'Delivery location',
//                                       hintStyle: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold),
//                                       contentPadding: EdgeInsets.all(15),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           spreadRadius: 1,
//                                           blurRadius: 2,
//                                           offset: Offset(4, 4),
//                                         )
//                                       ]),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Row(
//                                   children: [
//                                     const Text("Quantity"),
//                                     const Text("*",style: TextStyle(color:Colors.red),),
//                                   ],
//                                 ),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 Container(
//                                   height: 45,
//                                   width: MediaQuery.of(context).size.width/4,
//                                   child: TextField(
//                                     controller: qtyController,
//                                     keyboardType: TextInputType.number,
//                                     decoration: const InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10.0)),
//                                           borderSide:
//                                           BorderSide(color: Colors.white)),
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       hintText: 'Quantity',
//                                       hintStyle: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold),
//                                       contentPadding: EdgeInsets.all(15),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           spreadRadius: 1,
//                                           blurRadius: 2,
//                                           offset: Offset(4, 4),
//                                         )
//                                       ]),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 10, right: 10),
//                         child: Row(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text("Discount %"),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 Container(
//                                   height: 45,
//                                   width: MediaQuery.of(context).size.width/4,
//                                   child: TextField(
//                                     controller: discountPercentageController,
//                                     keyboardType: TextInputType.number,
//                                     decoration: const InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10.0)),
//                                           borderSide:
//                                           BorderSide(color: Colors.white)),
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       hintText: 'Discount %',
//                                       hintStyle: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold),
//                                       contentPadding: EdgeInsets.all(15),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           spreadRadius: 1,
//                                           blurRadius: 2,
//                                           offset: Offset(4, 4),
//                                         )
//                                       ]),
//                                 ),
//                               ],
//                             ),
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const Text("Remarks"),
//                                 const SizedBox(
//                                   height: 8,
//                                 ),
//                                 Container(
//                                   height: 45,
//                                   width: MediaQuery.of(context).size.width/4,
//                                   child: TextField(
//                                     controller: remarkscontroller,
//                                     keyboardType: TextInputType.text,
//                                     decoration: const InputDecoration(
//                                       border: OutlineInputBorder(
//                                           borderRadius: BorderRadius.all(
//                                               Radius.circular(10.0)),
//                                           borderSide:
//                                           BorderSide(color: Colors.white)),
//                                       filled: true,
//                                       fillColor: Colors.white,
//                                       hintText: 'Remakrs',
//                                       hintStyle: TextStyle(
//                                           fontSize: 14,
//                                           color: Colors.grey,
//                                           fontWeight: FontWeight.bold),
//                                       contentPadding: EdgeInsets.all(15),
//                                     ),
//                                   ),
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       borderRadius: BorderRadius.circular(15),
//                                       boxShadow: const [
//                                         BoxShadow(
//                                           color: Colors.grey,
//                                           spreadRadius: 1,
//                                           blurRadius: 2,
//                                           offset: Offset(4, 4),
//                                         )
//                                       ]),
//                                 ),
//                               ],
//                             ),
//
//                           ],
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//
//                       Center(
//                         child: SizedBox(
//                           height: 35,
//                           width: MediaQuery.of(context).size.width/4,
//                           child: ElevatedButton(
//                             onPressed: () async {
//                               final SharedPreferences pref = await SharedPreferences.getInstance();
//
//                             },
//                             style: ButtonStyle(
//                                 backgroundColor: MaterialStateProperty.all(
//                                     const Color(0xff5073d9)),
//                                 shape: MaterialStateProperty.all<
//                                     RoundedRectangleBorder>(
//                                   const RoundedRectangleBorder(
//                                     borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                     //  side: BorderSide(color: Colors.red)
//                                   ),
//                                 )),
//                             child: const Text(
//                               "Add",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 25,
//                       ),
//
//                     ],
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//
//   }
//
//
// }
//
//
// Future OpenDialog(BuildContext context) => showDialog(
//   context: context,
//   builder: (context) => AlertDialog(
//       title: SizedBox(
//         width: MediaQuery.of(context).size.width,
//         child: Column(
//           children: [
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
//             Container(
//               padding: const EdgeInsets.only(right: 160),
//               child: (const Text(
//                 'New Customer',
//                 style: TextStyle(
//                   fontSize: 18,
//                   color: Colors.grey,
//                   fontWeight: FontWeight.bold,
//                 ),
//               )),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0, right: 0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: 260,
//                     child: TextField(
//                       controller: firstName,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'First Name',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),
//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0, right: 0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: 125,
//                     child: TextField(
//                       controller: middleName,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Middle Name',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         // focusedBorder: InputBorder. none,
//                         // enabledBorder: InputBorder. none,
//                         // errorBorder: InputBorder. none,
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),
//
//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     height: 45,
//                     width: 125,
//                     child: TextField(
//                       controller: lastName,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Last Name',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),
//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0, right: 0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: 260,
//                     child: TextField(
//                       controller: address,
//                       keyboardType: TextInputType.text,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Address',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         // focusedBorder: InputBorder. none,
//                         // enabledBorder: InputBorder. none,
//                         // errorBorder: InputBorder. none,
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),
//
//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 15,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 0, right: 0),
//               child: Row(
//                 children: [
//                   Container(
//                     height: 45,
//                     width: 125,
//                     child: TextField(
//                       controller: contactNumber,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Contact No.',
//                         border: OutlineInputBorder(
//                             borderRadius:
//                             BorderRadius.all(Radius.circular(10.0)),
//                             borderSide: BorderSide(color: Colors.white)),
//                         // focusedBorder: InputBorder. none,
//                         // enabledBorder: InputBorder. none,
//                         // errorBorder: InputBorder. none,
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),
//
//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Container(
//                     height: 45,
//                     width: 125,
//                     child: TextField(
//                       controller: PanNumber,
//                       keyboardType: TextInputType.number,
//                       decoration: const InputDecoration(
//                         filled: true,
//                         fillColor: Colors.white,
//                         hintText: 'Pan No.',
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         hintStyle: TextStyle(
//                             fontSize: 14,
//                             color: Colors.grey,
//                             fontWeight: FontWeight.bold),
//                         contentPadding: EdgeInsets.all(15),
//                       ),
//                     ),
//                     decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(15),
//                         boxShadow: const [
//                           BoxShadow(
//                             color: Colors.grey,
//                             spreadRadius: 1,
//                             blurRadius: 2,
//                             offset: Offset(4, 4),
//                           )
//                         ]),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 35,
//               width: 130,
//               //color: Colors.grey,
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: ElevatedButton(
//                 onPressed: () async {
//                   if (firstName.text.isEmpty) {
//                     Fluttertoast.showToast(msg: "Please enter the First name.");
//                   }
//                   if (address.text.isEmpty) {
//                     Fluttertoast.showToast(msg: "Please enter address.");
//                   }
//                   else {
//                     createCustomer();
//                   }
//
//                   // calculation();
//                   // dateController.clear();
//                   //  pricecontroller.clear();
//
//                   //  qtycontroller.clear();
//                   //  discountPercentageController.clear();
//
//                   //AddProduct1();
//                 },
//                 style: ButtonStyle(
//                     backgroundColor:
//                     MaterialStateProperty.all(const Color(0xff2658D3)),
//                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                       const RoundedRectangleBorder(
//                         borderRadius: BorderRadius.all(Radius.circular(10)),
//                         //  side: BorderSide(color: Colors.red)
//                       ),
//                     )),
//                 child: const Text(
//                   "Add",
//                   style: TextStyle(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       )),
// );
//
//
//
//
// Future createCustomer() async {
//   final SharedPreferences sharedPreferences =
//   await SharedPreferences.getInstance();
//
//   final response = await http.post(
//       Uri.parse(ApiConstant.baseUrl + ApiConstant.createCustomer),
//       headers: {
//         'Content-Type': 'application/json',
//         'Accept': 'application/json',
//         'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
//       },
//       body: json.encode({
//         "device_type": 1,
//         "app_type": 1,
//         "first_name": firstName.text,
//         "middle_name": middleName.text,
//         "last_name": lastName.text,
//         "address": address.text,
//         "phone_no": contactNumber.text,
//         "mobile_no": '',
//         "email_id": "",
//         "pan_vat_no": PanNumber.text,
//         "tax_reg_system": 1,
//         "active": true,
//         "country": 1
//       }));
//   if (response.statusCode == 201) {
//     firstName.clear();
//     discountName.clear();
//     discountRate.clear();
//     middleName.clear();
//     lastName.clear();
//     address.clear();
//     contactNumber.clear();
//     PanNumber.clear();
//
//     Fluttertoast.showToast(msg: "Customer created successfully!");
//   }
//
//   if (kDebugMode) {
//     log('hello${response.statusCode}');
//   }
//   return response;
// }
//
// // Future OpenDialogDiscount(BuildContext context) => showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //           title: SizedBox(
// //         width: MediaQuery.of(context).size.width,
// //         child: Column(
// //           children: [
// //             Container(
// //               decoration: const BoxDecoration(),
// //               margin: const EdgeInsets.only(left: 220),
// //               child: GestureDetector(
// //                 child: CircleAvatar(
// //                     radius: 25,
// //                     backgroundColor: Colors.grey.shade100,
// //                     child:
// //                         const Icon(Icons.close, color: Colors.red, size: 16)),
// //                 onTap: () => Navigator.pop(context, true),
// //               ),
// //             ),
// //             Container(
// //               padding: const EdgeInsets.only(right: 120),
// //               child: (const Text(
// //                 'New Discount Scheme',
// //                 style: TextStyle(
// //                   fontSize: 14,
// //                   color: Colors.grey,
// //                   fontWeight: FontWeight.bold,
// //                 ),
// //               )),
// //             ),
// //             const SizedBox(
// //               height: 15,
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.only(left: 0, right: 0),
// //               child: Row(
// //                 children: [
// //                   Container(
// //                     height: 45,
// //                     width: 260,
// //                     child: TextField(
// //                       controller: discountName,
// //                       keyboardType: TextInputType.text,
// //                       decoration: const InputDecoration(
// //                         filled: true,
// //                         fillColor: Colors.white,
// //                         hintText: 'First Name',
// //                         border: OutlineInputBorder(
// //                             borderRadius:
// //                                 BorderRadius.all(Radius.circular(10.0)),
// //                             borderSide: BorderSide(color: Colors.white)),
// //                         // focusedBorder: InputBorder. none,
// //                         // enabledBorder: InputBorder. none,
// //                         // errorBorder: InputBorder. none,
// //                         hintStyle: TextStyle(
// //                             fontSize: 14,
// //                             color: Colors.grey,
// //                             fontWeight: FontWeight.bold),
//
// //                         contentPadding: EdgeInsets.all(15),
// //                       ),
// //                     ),
// //                     decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
// //                         borderRadius: BorderRadius.circular(15),
// //                         boxShadow: const [
// //                           BoxShadow(
// //                             color: Colors.grey,
// //                             spreadRadius: 1,
// //                             blurRadius: 2,
// //                             offset: Offset(4, 4),
// //                           )
// //                         ]),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 15,
// //             ),
// //             Padding(
// //               padding: const EdgeInsets.only(left: 0, right: 0),
// //               child: Row(
// //                 children: [
// //                   Container(
// //                     height: 45,
// //                     width: 260,
// //                     child: TextField(
// //                       controller: discountRate,
// //                       keyboardType: TextInputType.number,
// //                       decoration: const InputDecoration(
// //                         filled: true,
// //                         fillColor: Colors.white,
// //                         hintText: 'Rate',
// //                         border: OutlineInputBorder(
// //                             borderRadius:
// //                                 BorderRadius.all(Radius.circular(10.0)),
// //                             borderSide: BorderSide(color: Colors.white)),
// //                         // focusedBorder: InputBorder. none,
// //                         // enabledBorder: InputBorder. none,
// //                         // errorBorder: InputBorder. none,
// //                         hintStyle: TextStyle(
// //                             fontSize: 14,
// //                             color: Colors.grey,
// //                             fontWeight: FontWeight.bold),
//
// //                         contentPadding: EdgeInsets.all(15),
// //                       ),
// //                     ),
// //                     decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         // border:Border.all(color:Colors.white.withOpacity(0.8) ) ,
// //                         borderRadius: BorderRadius.circular(15),
// //                         boxShadow: const [
// //                           BoxShadow(
// //                             color: Colors.grey,
// //                             spreadRadius: 1,
// //                             blurRadius: 2,
// //                             offset: Offset(4, 4),
// //                           )
// //                         ]),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //             const SizedBox(
// //               height: 15,
// //             ),
// //             Container(
// //               height: 35,
// //               width: 130,
// //               //color: Colors.grey,
// //               padding: const EdgeInsets.only(left: 20, right: 20),
// //               child: ElevatedButton(
// //                 onPressed: () async {
// //                   createDiscountScheme();
// //                   // calculation();
// //                   // discountRate.clear();
// //                   // discountName.clear();
//
// //                   //  qtycontroller.clear();
// //                   //  discountPercentageController.clear();
//
// //                   //AddProduct1();
// //                 },
// //                 style: ButtonStyle(
// //                     backgroundColor:
// //                         MaterialStateProperty.all(const Color(0xff2658D3)),
// //                     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //                       const RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.all(Radius.circular(10)),
// //                         //  side: BorderSide(color: Colors.red)
// //                       ),
// //                     )),
// //                 child: const Text(
// //                   "Add",
// //                   style: TextStyle(
// //                     fontWeight: FontWeight.bold,
// //                     fontSize: 18,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       )),
// //     );
//
// // Future createDiscountScheme() async {
// //   final SharedPreferences sharedPreferences =
// //       await SharedPreferences.getInstance();
//
// //   final response = await http.post(
// //       Uri.parse(
// //           "https://api-soori-ims-staging.dipendranath.com.np/api/v1/core-app/discount-scheme"),
// //       headers: {
// //         'Content-Type': 'application/json',
// //         'Accept': 'application/json',
// //         'Authorization': 'Bearer ${sharedPreferences.get("access_token")}'
// //       },
// //       body: json.encode({
// //         "device_type": 1,
// //         "app_type": 1,
// //         "name": discountName.text,
// //         "editable": true,
// //         "rate": discountRate.text,
// //         "active": true
// //       }));
// //   if (kDebugMode) {
// //     // log(add.toString());
// //     log('hello${response.body}');
// //   }
// //   //log();
// //   return response;
//
// //   if (response.statusCode == 200) {
// //     // final String responseString = response.body;
//
// //     return response;
// //     return response.body;
//
// //     // return AddProductList.fromJson(responseString);
// //   }
// // }
//
