import 'package:flutter/material.dart';
import '../Models/bloodPressure.dart';

class BloodPressureProvider with ChangeNotifier {
  List<BloodPressure> bps = [];

  List<BloodPressure> get bloodPressures {
    return bps;
  }

  void addBloodPressure(BloodPressure bloodPressure) {
    bps.add(bloodPressure);
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
