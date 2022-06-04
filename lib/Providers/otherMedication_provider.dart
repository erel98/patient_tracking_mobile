import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/otherMedication.dart';
import 'package:patient_tracking/Services/otherMedication_service.dart';

class OtherMedicineProvider extends ChangeNotifier {
  List<OtherMedication> otherMeds = [];

  Future<void> getOtherMedications() async {
    otherMeds = await OtherMedicationService.getOtherMedications();
    notifyListeners();
  }

  void update(OtherMedication om) {
    otherMeds[otherMeds.indexWhere((m) => m.id == om.id)] = om;
    notifyListeners();
  }
}
