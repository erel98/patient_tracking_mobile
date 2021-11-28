import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/medicine.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:timezone/timezone.dart';

class DailyMeds extends StatefulWidget {
  final CalendarDay calendarDay;
  DailyMeds(this.calendarDay);

  @override
  _DailyMedsState createState() => _DailyMedsState();
}

class _DailyMedsState extends State<DailyMeds> {
  int boolIndex = 0;
  List<Item> _data = [];

  @override
  void initState() {
    super.initState();
    var currentEvents = widget.calendarDay.calendarEvents;
    for (int i = 0; i < currentEvents.length; i++) {
      if (currentEvents[i].saat == 0) {
        currentEvents[i].saat = 23.99;
        currentEvents.sort((a, b) => a.saat.compareTo(b.saat));
      }
    }

    for (int i = 0; i < currentEvents.length; i++) {
      for (int j = 0; j < currentEvents[i].medsToTake.length; j++) {
        _data.add(generateItem(
            currentEvents[i].medsToTake[j], widget.calendarDay, i));
      }
    }
  }

  void showAlertDialog(BuildContext context) {
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    AlertDialog alert = AlertDialog(
      title: Text("Dikkat!"),
      content: Text("Bu ilacın saati henüz gelmedi."),
      actions: [
        okButton,
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('62: ${DateTime.now()}');
    return SingleChildScrollView(child: _buildPanel());
  }

  Widget _buildPanel() {
    return ExpansionPanelList(
      expansionCallback: (int index, bool isExpanded) {
        setState(() {
          _data[index].isExpanded = !isExpanded;
        });
      },
      children: _data.map<ExpansionPanel>((Item item) {
        print('75 ${item.headerTitle} ${item.difference}');
        print(
            '76 ${DateTime.now().difference(DateTime(2021, 11, 28, 15)).inMinutes}');
        print('78 ${DateTime.now()}');
        return ExpansionPanel(
          headerBuilder: (BuildContext context, bool isExpanded) {
            return ListTile(
              title: Text(item.headerTitle,
                  style: TextStyle(
                      color: Colors.black,
                      //fontWeight: FontWeight.bold,
                      fontSize: 20)),
              subtitle: Text(item.headerSubtitle),
              trailing: item.isTaken
                  ? Icon(
                      FontAwesome5.smile_beam,
                      size: 40,
                      color: kPrimaryColor,
                    )
                  : item.difference < 0
                      ? Icon(
                          FontAwesome5.frown,
                          size: 40,
                          color: Colors.red,
                        )
                      : SizedBox(
                          height: 1,
                          width: 1,
                        ),
            );
          },
          body: ListTile(
            title: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 64,
                    height: 64,
                    child: item.bodyImage,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    item.bodyApproximation,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            trailing: ElevatedButton(
              child: Text(
                'Aldım',
                style: TextStyle(fontSize: 17),
              ),
              onPressed: () {
                if (item.difference < 0) {
                  null;
                } else if (item.difference <= 30 && item.difference > 0) {
                  setState(() {
                    item.isTaken = true;
                  });
                } else {
                  showAlertDialog(context);
                }
              },
            ),
          ),
          isExpanded: item.isExpanded,
        );
      }).toList(),
    );
  }
}

class Item {
  String headerTitle;
  String headerSubtitle;
  Icon headerEmoji;
  Image bodyImage;
  String bodyApproximation;
  bool isExpanded;
  double difference;
  bool isTaken;

  Item(
      {String headerTitle,
      String headerSubtitle,
      Icon headerEmoji,
      Image bodyImage,
      String bodyApproximation,
      bool isExpanded = false,
      double difference,
      bool isTaken = false}) {
    this.headerTitle = headerTitle;
    this.headerSubtitle = headerSubtitle;
    this.headerEmoji = headerEmoji;
    this.bodyImage = bodyImage;
    this.bodyApproximation = bodyApproximation;
    this.isExpanded = isExpanded;
    this.difference = difference;
    this.isTaken = isTaken;
  }
}

Item generateItem(Medicine med, CalendarDay calendarDay, int i) {
  DateTime medDate;
  var now = DateTime.now();
  medDate = DateTime(
      now.year, now.month, now.day, calendarDay.calendarEvents[i].saat.toInt());
  print('188 $medDate');
  var difference = medDate.difference(now).inMinutes;
  print('190 $difference');
  return Item(
      headerTitle:
          '${calendarDay.calendarEvents[i].saat == 23.99 ? 00 : calendarDay.calendarEvents[i].saat.toInt()}:00 ${med.name}',
      headerSubtitle: '${med.quantity} ${med.unit}',
      bodyImage: Image.asset(
        'assets/icons/test-ilac.jpg',
        scale: 0.5,
      ),
      bodyApproximation: difference >= 60
          ? 'Yaklaşık ${round(difference / 60)} saat kaldı'
          : difference >= 0
              ? '$difference dakika kaldı'
              : 'Bu ilacın saati geçti',
      difference: difference.toDouble());
}

int round(double number) {
  int floor = number.floor();
  int ceil = number.ceil();
  if ((number - floor) < (ceil - number)) {
    return floor;
  } else
    return ceil;
}
