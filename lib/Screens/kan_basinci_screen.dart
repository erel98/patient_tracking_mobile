import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/bloodPressure.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import '../Widgets/Graphs/bp_günlük_grafik.dart';
import '../Widgets/Graphs/bp_haftalık_grafik.dart';
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
  var hbController = TextEditingController();
  void addNewBp(BuildContext context) async {
    final bpProvider =
        Provider.of<BloodPressureProvider>(context, listen: false);
    BloodPressure bp = new BloodPressure(
        diastole: double.parse(kController.text),
        systole: double.parse(bController.text),
        heartBeat: int.parse(hbController.text));
    bpProvider.addBloodPressure(bp);
    kController.clear();
    bController.clear();
    hbController.clear();
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
          TextField(
            controller: hbController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'nabız',
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
    );
    return appBar;
  }

  bool isDaily = true;
  bool isWeekly = false;
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isDaily ? kPrimaryColor : Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      isDaily = true;
                      isWeekly = false;
                    });
                  },
                  child: Text('Günlük'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isWeekly ? kPrimaryColor : Colors.grey),
                  ),
                  onPressed: () {
                    setState(() {
                      isDaily = false;
                      isWeekly = true;
                    });
                  },
                  child: Text('Haftalık'),
                ),
              ],
            ),
          ),
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
              child: isDaily
                  ? BloodPressureGraphDaily()
                  : BloodPressureWeeklyGraph()),
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
            child: Consumer<BloodPressureProvider>(
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
