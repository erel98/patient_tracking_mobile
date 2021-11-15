import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:timezone/timezone.dart';

class DailyMeds extends StatefulWidget {
  final CalendarDay calendarDay;
  DailyMeds(this.calendarDay);

  @override
  _DailyMedsState createState() => _DailyMedsState();
}

class _DailyMedsState extends State<DailyMeds> {
  List<Widget> getDailyMeds() {
    var currentEvents = widget.calendarDay.calendarEvents;
    List<Widget> retVal = [];
    currentEvents.sort((a, b) => a.saat.compareTo(b.saat));

    var now = DateTime.now();
    var currentTime;

    for (int i = 0; i < currentEvents.length; i++) {
      if (currentEvents[i].saat == 0) {
        currentEvents[i].saat = 23.99;
        currentEvents.sort((a, b) => a.saat.compareTo(b.saat));
      }
      currentTime = TZDateTime(
        local,
        now.year,
        now.month,
        now.day,
        currentEvents[i].saat.toInt(),
        0,
        0,
      );
      for (int j = 0; j < currentEvents[i].medsToTake.length; j++) {
        var currentMed = currentEvents[i].medsToTake[j];
        retVal.add(Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: kSecondaryColor,
              border: Border.all(
                  color: now.difference(currentTime).inMinutes.abs() <= 30
                      ? Colors.red
                      : Colors.white)),
          child: ListTile(
            title: Text(
              '${currentEvents[i].saat == 23.99 ? 0 : currentEvents[i].saat.toInt()}:00 ${currentMed.name}',
              style: TextStyle(color: kTextColor, fontWeight: FontWeight.bold),
            ),
            subtitle: Text('${currentMed.quantity} ${currentMed.unit}'),
            trailing: Image.asset('assets/icons/Clock-icon.png'),
          ),
        ));
      }
    }

    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(children: getDailyMeds()));
  }
}
