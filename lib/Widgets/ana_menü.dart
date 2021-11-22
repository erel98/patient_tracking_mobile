import 'package:flutter/material.dart';
import '../global.dart';

class AnaMenuGrid extends StatefulWidget {
  final AppBar appBar;
  AnaMenuGrid(this.appBar);
  @override
  _AnaMenuGridState createState() => _AnaMenuGridState();
}

class _AnaMenuGridState extends State<AnaMenuGrid> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 3),
      height: MediaQuery.of(context).size.height -
          (70 +
              MediaQuery.of(context).size.height * 0.1 +
              widget.appBar.preferredSize.height +
              52),
      child: GridView(
          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 150,
            childAspectRatio: 1,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          padding: const EdgeInsets.all(25),
          children: Global.mainMenuItemList),
    );
  }
}
