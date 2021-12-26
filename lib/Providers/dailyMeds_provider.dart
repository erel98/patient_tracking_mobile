import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Services/medication_service.dart';

class DailyMedsProvider with ChangeNotifier {
  List<CalendarDay> calendarDays = [];

  Future<void> getDailyMeds() async {
    calendarDays = await MedicationService.getDailyMeds();
    notifyListeners();
  }
}
