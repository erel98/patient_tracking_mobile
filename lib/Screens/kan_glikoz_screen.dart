import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/bloodGlucose.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:patient_tracking/global.dart';
import '../Widgets/Graphs/bg_grafik.dart';
import 'package:patient_tracking/Widgets/blood_glucose_listview.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constraints.dart';

class BloodGlucoseScreen extends StatefulWidget {
  static final routeName = '/blood-glucose';

  @override
  _BloodGlucoseScreenState createState() => _BloodGlucoseScreenState();
}

class _BloodGlucoseScreenState extends State<BloodGlucoseScreen> {
  var controller = TextEditingController();

  void addNewBp(BuildContext context) async {
    final bgProvider =
        Provider.of<BloodGlucoseProvider>(context, listen: false);
    BloodGlucose bg = new BloodGlucose(value: int.parse(controller.text));
    bgProvider.addBloodGlucose(bg);
    controller.clear();
    Navigator.of(context).pop();
  }

  Alert addBpPopup(BuildContext context) {
    return Alert(
      context: context,
      content: Column(
        children: [
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'şeker değeri',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
        ],
      ),
      buttons: [
        DialogButton(
            color: kPrimaryColor,
            child: Text(
              'Kaydet',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                addNewBp(context);
              } else {
                Global.warnUser(context);
              }
            })
      ],
    );
  }

  AppBar getAppbar(BuildContext context) {
    final appBar = AppBar(
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
                  children: [
                    Text(
                      bgInfo,
                      style: TextStyle(height: 1.3),
                    ),
                  ],
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
    return appBar;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: Container(
        margin: EdgeInsets.only(right: 40),
        child: FloatingActionButton(
          elevation: 40,
          child: Icon(FontAwesome.tint),
          onPressed: () => addBpPopup(context).show(),
          backgroundColor: kPrimaryColor,
        ),
      ),
      resizeToAvoidBottomInset: false,
      appBar: getAppbar(context),
      body: Column(
        children: [
          TopContainer(),
          Container(
              margin: EdgeInsets.all(10),
              padding:
                  EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(10),
                ),
                color: Color(0xff232d37),
              ),
              child: BloodGlucoseGraph()),
          Container(
              height: height -
                  (getAppbar(context).preferredSize.height +
                      width * 0.1 +
                      20 +
                      300 +
                      20 +
                      66 +
                      21 +
                      27),
              child: BloodGlucoseList())
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
