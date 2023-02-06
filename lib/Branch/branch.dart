// import 'dart:convert';
// import 'package:flutter/material.dart';

// class Branch extends StatefulWidget {
//   const Branch({Key? key}) : super(key: key);

//   @override
//   _BranchState createState() => _BranchState();
// }

// class _BranchState extends State<Branch> {
//   BranchServices branchServices = BranchServices();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(100.0),
//         child: Center(
//           child: FutureBuilder(
//             future: branchServices.fetchBranchApiFromUrl(),
//             // initialData: InitialData,
//             builder: (BuildContext context, AsyncSnapshot snapshot) {
//               if (snapshot.hasData) {
//                 try {
//                   final snapshotData = jsonDecode(snapshot.data)[0];

//                   //  final id = snapshotData["id"];
//                   final name = snapshotData['name'];
//                   //  final address = snapshotData["address"];
//                   // final subDomain = snapshotData['sub_domain'];

//                   return Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       //   Text("Id is -> $id"),
//                       Text("Branch is -> $name"),
//                       //  Text("Schema is -> $address"),
//                       // Text("Subdomain is -> $subDomain"),
//                     ],
//                   );
//                 } catch (e) {
//                   throw Exception(e);
//                 }
//               } else {
//                 return Text(snapshot.error.toString());
//               }
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
