import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:patient_tracking/constraints.dart';
import '../Widgets/randevu_widget.dart';

class RandevuScreen extends StatefulWidget {
  static final String routeName = '/randevu-screen';
  @override
  _RandevuScreenState createState() => _RandevuScreenState();
}

class _RandevuScreenState extends State<RandevuScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: RandevuWidget(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kPrimaryColor,
        child: Icon(
          Icons.add,
          color: Colors.white,
          size: 35,
        ),
        onPressed: () => showModalBottomSheet(
            context: context,
            builder: (context) => Container(
                  height: 200,
                )),
      ),
    );
  }
}
