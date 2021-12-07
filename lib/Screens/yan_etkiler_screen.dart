import 'package:flutter/material.dart';
import 'package:patient_tracking/preferencesController.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constraints.dart';

class SideEffectsScreen extends StatefulWidget {
  static final routeName = '/side-effects';

  @override
  _SideEffectsScreenState createState() => _SideEffectsScreenState();
}

class _SideEffectsScreenState extends State<SideEffectsScreen> {
  final controller = TextEditingController();
  var prefs;

  void initText() async {
    prefs = await SharedPreferences.getInstance();
    controller.text = prefs.getString('side-effects');
  }

  void save(String saveText) async {
    prefs = await SharedPreferences.getInstance();
    prefs.setString('side-effects', controller.text);
  }

  void initState() {
    super.initState();
    initText();
  }

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              '** Bu alanı, yaşadığınız deneyimleri kaydedip randevunuz sırasında doktorunuza aktarırken hatırlamak için kullanabilirsiniz.',
              style: TextStyle(height: 1.5, color: Colors.black),
            ),
            alignment: Alignment.center,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: 500,
            margin: EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 20),
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border:
                  Border.all(color: Colors.black.withOpacity(0.2), width: 0.3),
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kPrimaryColor.withOpacity(0.23),
                ),
              ],
            ),
            child: TextField(
              controller: controller,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                hintStyle: TextStyle(
                  color: Colors.grey.withOpacity(0.5),
                ),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () => save,
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(kPrimaryColor)),
            child: Text(
              'Kaydet',
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
    );
  }
}
