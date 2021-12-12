import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/bloodPressures.dart';
import 'package:provider/provider.dart';
import '../Models/bloodPressure.dart';

class BloodPressureList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bpsData = Provider.of<BloodPressures>(context);
    final bps = bpsData.bps;
    Locale myLocale = Localizations.localeOf(context);
    return ListView.builder(
        itemCount: bps.length,
        itemBuilder: (context, int index) {
          return ListTile(
            leading: Icon(
              FontAwesome.heartbeat,
              color: Colors.red,
            ),
            title: Text(
              '${bps[index].bValue}/${bps[index].kValue}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            trailing: Text(
              '${DateFormat.yMMMEd(myLocale.toString()).format(bps[index].time)} ${bps[index].time.hour}:${bps[index].time.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          );
        });
  }
}
