import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../Widgets/diger_ilaclar_list.dart';

class OtherMeds extends StatefulWidget {
  static final routeName = '/diger-ilaclar';

  @override
  State<OtherMeds> createState() => _OtherMedsState();
}

class _OtherMedsState extends State<OtherMeds> {
  @override
  Widget build(BuildContext context) {
    final appbar = AppBar(
      elevation: 0,
      actions: [
        FittedBox(
          fit: BoxFit.fitHeight,
          child: IconButton(
            icon: Icon(
              FontAwesome5.question_circle,
              color: Colors.white,
            ),
            onPressed: () => Alert(
                context: context,
                content: Column(
                  children: [Text(medInfo)],
                ),
                buttons: [
                  DialogButton(
                      color: kPrimaryColor,
                      child: Text(
                        'Anladım',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () => Navigator.of(context).pop())
                ]).show(),
          ),
        )
      ],
    );
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: appbar,
      body: Column(
        children: [
          TopContainer(),
          Container(
              height: MediaQuery.of(context).size.height -
                  (appbar.preferredSize.height + 105),
              child: OtherUsedMeds()),
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
