import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Services/medication_service.dart';

class DailyMedsProvider with ChangeNotifier {
  CalendarDay monday = CalendarDay();
  CalendarDay tuesday = CalendarDay();
  CalendarDay wednesday = CalendarDay();
  CalendarDay thursday = CalendarDay();
  CalendarDay friday = CalendarDay();
  CalendarDay saturday = CalendarDay();
  CalendarDay sunday = CalendarDay();

  Future<void> getDailyMeds() async {
    monday = await MedicationService.getDailyMeds(1);
    notifyListeners();
    tuesday = await MedicationService.getDailyMeds(2);
    notifyListeners();
    wednesday = await MedicationService.getDailyMeds(3);
    notifyListeners();
    thursday = await MedicationService.getDailyMeds(4);
    notifyListeners();
    friday = await MedicationService.getDailyMeds(5);
    notifyListeners();
    saturday = await MedicationService.getDailyMeds(6);
    notifyListeners();
    sunday = await MedicationService.getDailyMeds(7);
    notifyListeners();
  }
}
