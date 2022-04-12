import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constraints.dart';

class NotesScreen extends StatefulWidget {
  static final routeName = '/notes';

  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
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
    final appBar = AppBar(
      elevation: 0,
    );
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        children: [
          TopContainer(),
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
            height: MediaQuery.of(context).size.height -
                (10 + 15 + 15 + 250 + MediaQuery.of(context).size.height * 0.1),
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
              maxLines: null,
              controller: controller,
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
            onPressed: () {
              EasyLoading.show(status: 'Yükleniyor...');
              save(controller.text);
              Navigator.of(context).pop();
              EasyLoading.dismiss();
            },
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
