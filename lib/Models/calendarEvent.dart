import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/medicationVariant.dart';

class CalendarEvent {
  int id;
  DateTime takeTime;
  DailyMedication dailyMedication; //aynı saatte alınabilecek ilaçlar

  CalendarEvent({this.id, this.takeTime, this.dailyMedication});
}
