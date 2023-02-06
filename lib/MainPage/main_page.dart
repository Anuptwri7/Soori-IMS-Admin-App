import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../Constant/apiConstant.dart';
import '../Login/login_screen.dart';
import '../TabPages/homeTabPage.dart';
import '../TabPages/moreTabPage.dart';
import '../TabPages/profileTabPage.dart';
import '../TabPages/stockAnaysisTapPage.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;


  Future<void> catchCodeName() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.getStringList("permission_code_name").toString() ;
    log("codes name"+ pref.getStringList("permission_code_name").toString());
  }
  Future<void> checkRefresh() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    // log(pref.getString('refresh_token').toString());
    var response = await http.post(
      Uri.parse(ApiConstant.baseUrl + ApiConstant.refreshToken),
      body: ({
        'refresh': pref.getString('refresh_token').toString(),
      }),
    );
    // log(response.body);
    try {
      if (response.statusCode == 200) {
        pref.setString("access_token", json.decode(response.body)['access']);
      } else if (response.statusCode == 401) {
        pref.clear();
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginScreen()));
      }
    } catch (e) {
      throw Exception(e);
    }
  }
  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {

    catchCodeName();
    super.initState();
    checkRefresh();
    tabController = TabController(length: 4, vsync: this);
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: tabController,
        children: const [
          HomeTabPage(),
          StockAnaysisTabPage(),
          MoreTabPage(),
          ProfileTabPage(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        iconList: const [
          Icons.home,
          Icons.align_vertical_bottom_rounded,
          Icons.brightness_5_outlined,
          Icons.person,
        ],
        onChange: (index) {
          setState(() {
            selectedIndex = index;
            tabController!.index = selectedIndex;
          });
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatefulWidget {
  final int defaultSelectedIndex;

  final Function(int) onChange;
  final List<IconData> iconList;

  const CustomBottomNavigationBar(
      {this.defaultSelectedIndex = 0,
      required this.iconList,
      required this.onChange});

  @override
  _CustomBottomNavigationBarState createState() =>
      _CustomBottomNavigationBarState();
}

class _CustomBottomNavigationBarState extends State<CustomBottomNavigationBar> {
  int _selectedIndex = 0;
  List<IconData> _iconList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _selectedIndex = widget.defaultSelectedIndex;
    _iconList = widget.iconList;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _navBarItemList = [];

    for (var i = 0; i < _iconList.length; i++) {
      _navBarItemList.add(buildNavBarItem(_iconList[i], i));
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _navBarItemList,
    );
  }

  Widget buildNavBarItem(IconData icon, int index) {
    return GestureDetector(
      onTap: () {
        widget.onChange(index);
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 10.0, right: 0, bottom: 10),
        child: Container(
          height: 70,
          width: 72,
          decoration: index == _selectedIndex
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade500,
                      offset: const Offset(4, 4),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                )
              : BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.shade100,
                      offset: const Offset(5, 8),
                      spreadRadius: 1,
                      blurRadius: 2,
                    ),
                  ],
                ),
          child: Icon(
            icon,
            color: index == _selectedIndex ?const Color(0xff2c51a4) : Colors.grey,
          ),
        ),
      ),
    );
  }
}
