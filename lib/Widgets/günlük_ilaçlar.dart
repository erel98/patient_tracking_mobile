import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/constraints.dart';

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
      currentEvents
          .sort((a, b) => a.saat.toString().compareTo(b.saat.toString()));
    }

    for (int i = 0; i < currentEvents.length; i++) {
      _data.add(generateItem(
          currentEvents[i].dailyMedication, widget.calendarDay, i));
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
    // print('62: ${DateTime.now()}');
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
                  : item.difference < 0 && item.isFuture
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
                onPressed: item.difference < 0
                    ? null
                    : () {
                        if (item.difference <= 30 && item.difference > 0) {
                          setState(() {
                            item.isTaken = true;
                          });
                        } else if (item.difference > 30) {
                          showAlertDialog(context);
                        }
                      }),
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
  bool isFuture;

  Item(
      {String headerTitle,
      String headerSubtitle,
      Icon headerEmoji,
      Image bodyImage,
      String bodyApproximation,
      bool isExpanded = false,
      double difference,
      bool isTaken = false,
      bool isFuture}) {
    this.headerTitle = headerTitle;
    this.headerSubtitle = headerSubtitle;
    this.headerEmoji = headerEmoji;
    this.bodyImage = bodyImage;
    this.bodyApproximation = bodyApproximation;
    this.isExpanded = isExpanded;
    this.difference = difference;
    this.isTaken = isTaken;
    this.isFuture = isFuture;
  }
}

Item generateItem(DailyMedication med, CalendarDay calendarDay, int i) {
  DateTime medDate;
  var now = DateTime.now();
  medDate = DateTime(
      now.year,
      now.month,
      now.day,
      calendarDay.calendarEvents[i].saat.hour,
      calendarDay.calendarEvents[i].saat.minute);
  var difference = medDate.difference(now).inMinutes;
  bool isFuture = medDate.isAfter(DateTime.now());
  bool isTaken = false;
  return Item(
      headerTitle:
          '${calendarDay.calendarEvents[i].saat.hour.toString().padLeft(2, '0')}:${calendarDay.calendarEvents[i].saat.minute.toString().padLeft(2, '0')} ${med.medicationName}',
      headerSubtitle: '${med.quantity}',
      bodyImage: Image.network(
        med.imageUrl,
        scale: 0.5,
      ),
      bodyApproximation: difference >= 60 && !isFuture
          ? 'Yaklaşık ${round(difference / 60)} saat kaldı'
          : isFuture
              ? ''
              : difference >= 0
                  ? '$difference dakika kaldı'
                  : !isTaken
                      ? 'Bu ilacın saati geçti'
                      : 'İlacınızı vaktinde aldınız',
      difference: difference.toDouble(),
      isFuture: isFuture);
}

int round(double number) {
  int floor = number.floor();
  int ceil = number.ceil();
  if ((number - floor) < (ceil - number)) {
    return floor;
  } else
    return ceil;
}
