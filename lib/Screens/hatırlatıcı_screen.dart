import 'dart:math';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Widgets/hava_durumu.dart';
import 'package:patient_tracking/Widgets/randevu_widget.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import '../BildirimAPI.dart';
import '../constraints.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
  TabController _tabController;
  DateTime randevuTarih;
  TimeOfDay randevuSaat;
  void _handleTabSelection() async {
    setState(() {
      _currentIndex = _tabController.index;
    });
  }

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(_handleTabSelection);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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

  void _warnUser() {
    AlertDialog alert = AlertDialog(
      title: Text("Dikkat!"),
      content: Text("Lütfen tarih ve saat alanlarını doldurunuz."),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Anladım')),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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
              if (dateController.text.isNotEmpty &&
                  hourController.text.isNotEmpty) {
                //api call
                final DateTime notificationDate = DateTime(
                    randevuTarih.year,
                    randevuTarih.month,
                    randevuTarih.day,
                    randevuSaat.hour,
                    randevuSaat.minute);
                BildirimAPI.showScheduledNotification(
                  id: Random().nextInt(999999),
                  title: titleController.text,
                  body: 'Hastane randevunuz yaklaşıyor!',
                  scheduledDate: notificationDate,
                );
                dateController.clear();
                hourController.clear();
                titleController.clear();

                await BildirimAPI.showScheduledNotification(
                    title: 'denemece', body: 'denemece2');

                Navigator.pop(context);
              } else {
                _warnUser();
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
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: TabBar(
          indicatorColor: Colors.white,
          controller: _tabController,
          tabs: _tabs,
        ),
      ),
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
            child: TabBarView(
              controller: _tabController,
              children: [
                RandevuWidget(),
                Weather(),
              ],
            ),
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

List<Widget> get _tabs {
  return [
    Tab(
      icon: Icon(
        Icons.local_hospital,
      ),
      child: Text('Randevularım'),
    ),
    Tab(
      icon: Icon(Icons.cloud),
      child: Text('Hava durumu bildirimleri'),
    ),
  ];
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
