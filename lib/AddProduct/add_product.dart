import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController customernamecontroller = TextEditingController();
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController qtycontroller = TextEditingController();
  TextEditingController pricecontroller = TextEditingController();
  TextEditingController remarkscontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            child: Column(
              children: const [],
            ),
          ),
        ),
      ),
    );
  }
}
