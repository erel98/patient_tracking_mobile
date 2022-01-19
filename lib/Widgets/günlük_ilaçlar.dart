import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Services/medication_service.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
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
      currentEvents.sort(
          (a, b) => a.takeTime.toString().compareTo(b.takeTime.toString()));
    }

    for (int i = 0; i < currentEvents.length; i++) {
      _data.add(generateItem(
          currentEvents[i].dailyMedication, widget.calendarDay, i));
    }

    _data.forEach((element) {
      //print('initstate id: ${element.id}');
      //print('initstate tit: ${element.headerTitle}');
      //print('initstate subt: ${element.headerSubtitle}');
      //print('initstate dif: ${element.difference}');
    });
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
    print('şuan length: ${_data.length}');
    _data.forEach((element) {
      print('item var');
    });
    return SingleChildScrollView(
        child: _data.isNotEmpty
            ? _buildPanel()
            : Container(
                width: MediaQuery.of(context).size.width,
                height: 500,
                child: NoDataFound('Bugün ilacınız')));
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
                  : item.difference < 0 && !item.isFuture
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
                onPressed: (item.difference < -medTolerance) || item.isTaken
                    ? null
                    : () async {
                        if (item.difference <= 15 &&
                            item.difference > -medTolerance) {
                          MedicationService.updateDailyMedication(
                              item.dailyMedication.id);
                          setState(() {
                            item.dailyMedication.tookAt = DateTime.now();
                            item.isTaken = true;
                            //print('133 sadece //print: ${item.id}');
                          });
                        } else if (item.difference > 15) {
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
  DailyMedication dailyMedication;
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
      {DailyMedication dailyMedication,
      String headerTitle,
      String headerSubtitle,
      Icon headerEmoji,
      Image bodyImage,
      String bodyApproximation,
      bool isExpanded = false,
      double difference,
      bool isTaken = false,
      bool isFuture}) {
    this.dailyMedication = dailyMedication;
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
  medDate = calendarDay.calendarEvents[i].takeTime;
  var difference = medDate.difference(now).inMinutes;
  bool isFuture = medDate.isAfter(DateTime.now());
  bool isTaken = med.tookAt == null ? false : true;
  //print('188 daily med id: ${med.id}');
  return Item(
    dailyMedication: med,
    headerTitle:
        '${calendarDay.calendarEvents[i].takeTime.hour.toString().padLeft(2, '0')}:${calendarDay.calendarEvents[i].takeTime.minute.toString().padLeft(2, '0')} ${med.medicationName}',
    headerSubtitle: '${med.quantity}',
    bodyImage: Image.network(
      med.imageUrl,
      scale: 0.5,
    ),
    bodyApproximation: isTaken
        ? 'İlacı vaktinde aldınız'
        : difference > 1440
            ? 'Yaklaşık ${round(difference / 1440)} gün kaldı'
            : difference > 60 && difference < 1440
                ? 'Yaklaşık ${round(difference / 60)} saat kaldı'
                : difference > 15 && difference < 60
                    ? '$difference dakika kaldı'
                    : difference > -15 && difference < 15
                        ? 'İlacınızı hemen alınız'
                        : difference < -15
                            ? 'Bu ilacın saati geçti'
                            : '',
    difference: difference.toDouble(),
    isFuture: isFuture,
    isTaken: isTaken,
  );
}

int round(double number) {
  int floor = number.floor();
  int ceil = number.ceil();
  if ((number - floor) < (ceil - number)) {
    return floor;
  } else
    return ceil;
}
