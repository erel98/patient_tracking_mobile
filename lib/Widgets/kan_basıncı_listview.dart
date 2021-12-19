import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:patient_tracking/Services/bp_service.dart';
import 'package:provider/provider.dart';
import '../Models/bloodPressure.dart';

class BloodPressureList extends StatelessWidget {
  String printTansiyon(double tansiyon) {
    String retVal = tansiyon.toString();
    retVal = retVal.replaceAll('.0', '');
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    final bpsData = context.watch<BloodPressureProvider>();
    final bps = bpsData.bloodPressures;
    bps.forEach((element) {
      print(element.heartBeat);
    });
    Locale myLocale = Localizations.localeOf(context);
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
        itemCount: bps.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
              '${DateFormat.yMMMEd(myLocale.toString()).format(bps[index].time)} ${bps[index].time.hour}:${bps[index].time.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            trailing: Column(
              children: [
                Text(
                  '${printTansiyon(bps[index].bValue)}/${printTansiyon(bps[index].kValue)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  '${bps[index].heartBeat}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          );
        });
  }
}
