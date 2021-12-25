import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Services/medication_service.dart';

class MedicineProvider extends ChangeNotifier {
  List<MedicationVariant> medVariants = [];
  bool isLoading = true;
  void getMedVariants(context) async {
    medVariants = await MedicationService.getMyMedications();
    isLoading = false;
    notifyListeners();
  }

  void addMedicineVariant(MedicationVariant mv) {
    medVariants.add(mv);
    notifyListeners();
  }

  void update(MedicationVariant mv) {
    medVariants[medVariants.indexWhere((m) => m.id == mv.id)] = mv;
    notifyListeners();
  }

  void empty() {
    medVariants.clear();
  }
}
