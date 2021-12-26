import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/medicationVariant.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Services/medication_service.dart';

class MedicineProvider extends ChangeNotifier {
  List<MedicationUser> medUsers = [];
  bool isLoading = true;
  void getMedicationUsers(context) async {
    medUsers = await MedicationService.getMyMedications();
    isLoading = false;
    notifyListeners();
  }

  void getDailyMeds(context, CalendarDay day) async {
    //day = await MedicationService.getDailyMeds();
  }

  void update(MedicationUser mu) {
    medUsers[medUsers.indexWhere((m) => m.id == mu.id)] = mu;
    notifyListeners();
  }

  void empty() {
    medUsers.clear();
  }
}
