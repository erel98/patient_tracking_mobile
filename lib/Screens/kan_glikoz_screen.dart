import 'package:flutter/material.dart';
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
          child: Image.asset(
            'assets/icons/blood-pressure.png',
            scale: 1.3,
          ),
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
              margin: EdgeInsets.all(20),
              padding:
                  EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 10),
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
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
