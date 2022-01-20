import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Models/randevu.dart';
import 'package:patient_tracking/Providers/randevu_provider.dart';
import 'package:patient_tracking/Widgets/randevu_widget.dart';
import 'package:provider/provider.dart';
import '../constraints.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../global.dart';

class Hatirlatici extends StatefulWidget {
  static var routeName = '/hatirlatici';
  @override
  _HatirlaticiState createState() => _HatirlaticiState();
}

class _HatirlaticiState extends State<Hatirlatici>
    with SingleTickerProviderStateMixin {
  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var hourController = TextEditingController();
  int _currentIndex = 0;

  DateTime randevuTarih;
  TimeOfDay randevuSaat;

  void initState() {
    super.initState();
  }

  void _showDatePicker() async {
    var now = DateTime.now();
    randevuTarih = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(now.year, now.month + 3),
        cancelText: 'İptal',
        confirmText: 'Onay',
        errorFormatText: 'Lütfen GG.AA.YYYY şeklinde giriniz!',
        errorInvalidText: 'Lütfen bir tarih giriniz',
        helpText: '',
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData(
              primaryColor: kPrimaryColor,
            ),
            child: child,
          );
        });
    dateController.text =
        '${randevuTarih.day}.${randevuTarih.month}.${randevuTarih.year}';
  }

  void _showTimePicker() async {
    var now = DateTime.now();
    randevuSaat = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: now.hour, minute: now.minute),
      initialEntryMode: TimePickerEntryMode.input,
      cancelText: 'İptal',
      confirmText: 'Onay',
      errorInvalidText: 'Lütfen geçerli bir saat giriniz!',
      helpText: '',
    );
    hourController.text = '${randevuSaat.hour}:${randevuSaat.minute}';
  }

  void _addNewRandevu() {
    Alert(
        context: context,
        content: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'randevu adı',
              ),
            ),
            TextField(
              controller: dateController,
              readOnly: true,
              showCursor: true,
              decoration: InputDecoration(
                  icon: Icon(
                FontAwesome5.calendar_alt,
                color: Colors.black,
              )),
              onTap: _showDatePicker,
            ),
            TextField(
              controller: hourController,
              readOnly: true,
              showCursor: true,
              decoration: InputDecoration(
                  icon: Icon(
                FontAwesome5.clock,
                color: Colors.black,
              )),
              onTap: _showTimePicker,
            ),
          ],
        ),
        buttons: [
          DialogButton(
            color: kPrimaryColor,
            onPressed: () async {
              Locale myLocale = Localizations.localeOf(context);
              if (dateController.text.isNotEmpty &&
                  hourController.text.isNotEmpty &&
                  titleController.text.isNotEmpty) {
                String formattedText = DateFormat('yyyy-MM-dd HH:mm:ss').format(
                    DateTime(
                        randevuTarih.year,
                        randevuTarih.month,
                        randevuTarih.day,
                        randevuSaat.hour,
                        randevuSaat.minute));

                final DateTime notificationDate = DateTime.parse(formattedText);
                var currentRandevu = Randevu(
                    date: notificationDate, reminderText: titleController.text);
                final randevuProvider =
                    Provider.of<RandevuProvider>(context, listen: false);
                randevuProvider.addRandevu(currentRandevu);
                dateController.clear();
                hourController.clear();
                titleController.clear();

                Navigator.pop(context);
              } else {
                Global.warnUser(context);
              }
            },
            child: Text(
              "KAYDET",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
  }

  @override
  Widget build(BuildContext context) {
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
                      randevuInfo,
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
    var mq = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar,
      body: Column(
        children: [
          TopContainer(),
          Container(
            height: mq.height -
                (mq.height * 0.1 + appBar.preferredSize.height + 25),
            child: RandevuWidget(),
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? CircleAvatar(
              backgroundColor: kPrimaryColor,
              child: IconButton(
                onPressed: () => _addNewRandevu(),
                icon: Icon(Icons.add, color: Colors.white),
              ),
            )
          : Container(),
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
