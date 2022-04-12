import 'package:flutter/material.dart';
import 'package:patient_tracking/Widgets/history_listview.dart';

import '../constraints.dart';

class HistoryScreen extends StatefulWidget {
  static final routeName = '/history';

  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final appbar = AppBar(
    elevation: 0,
  );
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appbar,
      body: Column(
        children: [
          TopContainer(),
          Container(
            height: mq.height - (mq.height * 0.1 + 20 + 70),
            child: HistoryList(),
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
      height: MediaQuery.of(context).size.height * 0.05,
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
