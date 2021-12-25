import 'package:flutter/material.dart';

import '../constraints.dart';

class OrganTransplantScreen extends StatelessWidget {
  static final routeName = '/organ-transplant';

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final appBar = AppBar(
      elevation: 0,
    );
    return Scaffold(
      appBar: appBar,
      body: Column(
        children: [
          TopContainer(),
          Container(
            height: mq.height * 0.7,
            width: mq.width * 0.9,
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: kPrimaryColor.withOpacity(0.23),
                  blurRadius: 50,
                  offset: Offset(0, 10),
                ),
              ],
            ),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                enabled: false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.1,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: kPrimaryColor),
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
