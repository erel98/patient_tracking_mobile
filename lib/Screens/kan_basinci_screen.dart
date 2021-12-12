import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/bloodPressures.dart';
import 'package:patient_tracking/Widgets/grafik.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:patient_tracking/Widgets/kan_bas%C4%B1nc%C4%B1_listview.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

class BloodPressureScreen extends StatefulWidget {
  static final routeName = '/blood-pressure';

  @override
  _BloodPressureScreenState createState() => _BloodPressureScreenState();
}

class _BloodPressureScreenState extends State<BloodPressureScreen> {
  AppBar getAppbar(BuildContext context) {
    final appBar = AppBar(
      elevation: 0,
      actions: [
        IconButton(
            onPressed: () => showMaterialModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.only(left: 100),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text('Küçük tansiyon:')),
                              Card(
                                elevation: 20,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: 3, left: 3, top: 5, bottom: 1),
                                  height: 25,
                                  width: 50,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 10),
                                  child: Text('Büyük tansiyon:')),
                              Card(
                                elevation: 20,
                                child: Container(
                                  padding: EdgeInsets.only(
                                      right: 3, left: 3, top: 5, bottom: 1),
                                  height: 25,
                                  width: 50,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.auto,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: ElevatedButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text('Kaydet'),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
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
            padding: const EdgeInsets.only(right: 50, left: 75),
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
