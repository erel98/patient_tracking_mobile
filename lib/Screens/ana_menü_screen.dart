import 'package:flutter/material.dart';
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
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        leading: IconButton(
          onPressed: null,
          icon: Icon(
            Icons.menu,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Uygulama İsmi",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: null,
              icon: Icon(
                Icons.info,
                size: 25,
                color: Colors.white,
              ))
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        selectedItemColor: Colors.black,
        unselectedIconTheme: IconThemeData(opacity: 0.5),
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        selectedIconTheme: IconThemeData(opacity: 1),
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Ana Ekran'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil')
        ],
        currentIndex: Global.initialState,
        onTap: onItemTapped,
      ),
      body: widgetOptions.elementAt(Global.initialState),
    );
  }
}
