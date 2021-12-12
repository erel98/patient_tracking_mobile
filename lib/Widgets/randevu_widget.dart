import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/randevus.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class RandevuWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final randevuData = Provider.of<Randevus>(context);
    final randevus = randevuData.randevus;
    return ListView.builder(
        itemCount: randevus.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(
              randevus[index].reminderText,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Text(
              randevus[index].date.toString(),
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          );
        });
  }
}
