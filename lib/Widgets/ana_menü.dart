import 'package:flutter/material.dart';
import '../global.dart';

class AnaMenuGrid extends StatefulWidget {
  @override
  _AnaMenuGridState createState() => _AnaMenuGridState();
}

class _AnaMenuGridState extends State<AnaMenuGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 100,
            childAspectRatio: 1.2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(25),
          children: Global.mainMenuItemList),
    );
  }
}
