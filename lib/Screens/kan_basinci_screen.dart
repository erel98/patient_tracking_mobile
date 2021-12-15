import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/bloodPressures.dart';
import 'package:patient_tracking/Widgets/grafik.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:patient_tracking/Widgets/kan_bas%C4%B1nc%C4%B1_listview.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../constraints.dart';

class BloodPressureScreen extends StatefulWidget {
  static final routeName = '/blood-pressure';

  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  var kController = TextEditingController();
  var bController = TextEditingController();
  Future<bool> addNewBp(BuildContext context) {
    kController.clear();
    bController.clear();
    //API call
    Navigator.of(context).pop();
  }

  Alert addBpPopup(BuildContext context) {
    return Alert(
      context: context,
      content: Column(
        children: [
          TextField(
            controller: kController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'küçük tansiyon',
              floatingLabelBehavior: FloatingLabelBehavior.auto,
            ),
          ),
          TextField(
            controller: bController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'büyük tansiyon',
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
            onPressed: () {
              if (kController.text.isNotEmpty && bController.text.isNotEmpty) {
                addNewBp(context);
              }
            })
      ],
    );
  }

  AppBar getAppbar(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () => addBpPopup(context).show(),
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ))
      ],
    );
    return appBar;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: getAppbar(context),
      body: Column(
        children: [
          TopContainer(),
          Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.only(right: 20, left: 20, top: 10, bottom: 1),
              width: MediaQuery.of(context).size.width,
              height: 300,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37),
              ),
              child: Graph()),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 10),
            child: Row(
              children: [
                Text(
                  'Tansiyon',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
                Spacer(),
                Text(
                  'Nabız',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
                Spacer(),
                Text(
                  'Ölçüm tarihi',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      fontSize: 18),
                ),
              ],
            ),
          ),
          Container(
            height: height -
                (getAppbar(context).preferredSize.height +
                    width * 0.1 +
                    20 +
                    300 +
                    20 +
                    66 +
                    21),
            child: Consumer<BloodPressures>(
              builder: (_, bps, child) => BloodPressureList(),
            ),
          )
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
