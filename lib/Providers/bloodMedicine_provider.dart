import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/bloodMedicine.dart';
import 'package:patient_tracking/Services/bm_service.dart';

class BloodMedicineProvider with ChangeNotifier {
  List<BloodMedicine> bms = [];

  void getBloodMedicines() async {
    bms = await BloodMedicineService.getBloodMedicines();
    notifyListeners();
  }
}
