import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/bloodPressure.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:patient_tracking/Services/bp_service.dart';
import 'package:patient_tracking/Widgets/Graphs/bp_g%C3%BCnl%C3%BCk_grafik.dart';
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
  var hbController = TextEditingController();
  Future<bool> addNewBp(BuildContext context) async {
    var success = await BloodPressureService.postBloodPressure(
        kController.text, bController.text, hbController.text);
    kController.clear();
    bController.clear();
    Navigator.of(context).pop();
    return success;
  }

  void fetchBloodPressures(BuildContext context) async {
    var bpProvider = context.read<BloodPressureProvider>();
    bpProvider.empty();
    List<BloodPressure> list = await BloodPressureService.getBloodPressures();
    list.forEach((element) {
      bpProvider.addBloodPressure(element);
    });
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
                var success = await addNewBp(context);
                if (success) {
                  Fluttertoast.showToast(msg: 'Tansiyonunuz başarıyla eklendi');
                } else {
                  Fluttertoast.showToast(
                      msg: 'Hay aksi! Bir şeyler ters gitti');
                }
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

  bool isDaily = true;
  bool isWeekly = false;
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    fetchBloodPressures(context);
    return Scaffold(
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
                    isDaily = true;
                    isWeekly = false;
                  },
                  child: Text('Günlük'),
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        isWeekly ? kPrimaryColor : Colors.grey),
                  ),
                  onPressed: () {
                    isDaily = false;
                    isWeekly = true;
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
              child: BloodPressureGraphDaily()),
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
