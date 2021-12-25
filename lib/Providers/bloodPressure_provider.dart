import 'package:flutter/material.dart';
import 'package:patient_tracking/Services/bp_service.dart';
import '../Models/bloodPressure.dart';

class BloodPressureProvider with ChangeNotifier {
  List<BloodPressure> bps = [];
  bool isLoading = true;

  void getBloodPressures(context) async {
    bps = await BloodPressureService.getBloodPressures();
    isLoading = false;
    notifyListeners();
  }

  void addBloodPressure(BloodPressure bp) async {
    var newbp = await BloodPressureService.postBloodPressure(bp);

    var diastole = newbp.diastole.toString().replaceAll(',', '.');
    var systole = newbp.systole.toString().replaceAll(',', '.');

    newbp.systole = double.parse(systole);
    newbp.diastole = double.parse(diastole);
    bps.add(newbp);
    notifyListeners();
  }

  void update(BloodPressure bloodPressure) {
    bps[bps.indexWhere((m) => m.id == bloodPressure.id)] = bloodPressure;
    notifyListeners();
  }

  void empty() {
    bps.clear();
  }
}
