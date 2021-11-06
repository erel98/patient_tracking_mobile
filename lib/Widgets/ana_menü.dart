import 'package:flutter/material.dart';
import '../global.dart';

class AnaMenuGrid extends StatefulWidget {
  @override
  _AnaMenuGridState createState() => _AnaMenuGridState();
}

class _AnaMenuGridState extends State<AnaMenuGrid> {
  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
          childAspectRatio: 1,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        padding: const EdgeInsets.all(25),
        children: Global.mainMenuItemList);
  }
}
