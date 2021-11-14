import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/constraints.dart';
import '../global.dart';
import '../Widgets/ana_menü.dart';
import '../Widgets/accountMenu.dart';

class AnaMenu extends StatefulWidget {
  static const routeName = '/ana-menu';
  @override
  _AnaMenuState createState() => _AnaMenuState();
}

class _AnaMenuState extends State<AnaMenu> {
  List<Widget> widgetOptions = <Widget>[
    AnaMenuGrid(),
    AccountMenu(),
  ];
  void onItemTapped(int index) {
    setState(() {
      Global.initialState = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: kPrimaryColor,
          leading: IconButton(
            onPressed: null,
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
          ),
        ),
        bottomNavigationBar: bottomNavBar(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height * 0.1,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  Text(
                    'Hoşgeldiniz Adile Hanım',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Spacer(),
                  Icon(FontAwesome.smile_o)
                ],
              ),
            ),
            widgetOptions.elementAt(Global.initialState),
          ],
        ));
  }

  Container bottomNavBar() {
    return Container(
      padding: EdgeInsets.only(left: 50, right: 50, bottom: 10),
      height: 70,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
            offset: Offset(0, -10),
            blurRadius: 35,
            color: kPrimaryColor.withOpacity(0.38))
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: Icon(FontAwesome.home),
            onPressed: () => onItemTapped(0),
          ),
          IconButton(
            icon: Icon(FontAwesome.user),
            onPressed: () => onItemTapped(1),
          )
        ],
      ),
    );
  }
}
