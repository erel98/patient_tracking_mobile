import 'package:flutter/material.dart';
import '../Models/bloodPressure.dart';

class BloodPressures with ChangeNotifier {
  List<BloodPressure> _bps = [
    BloodPressure(
        id: 1, kValue: 72, bValue: 116, time: DateTime(2021, 12, 7, 9)),
    BloodPressure(
        id: 2, kValue: 86, bValue: 124, time: DateTime(2021, 12, 7, 12)),
    BloodPressure(
        id: 3, kValue: 90, bValue: 130, time: DateTime(2021, 12, 7, 15)),
    BloodPressure(
        id: 4, kValue: 80, bValue: 120, time: DateTime(2021, 12, 7, 18)),
    BloodPressure(
        id: 5, kValue: 70, bValue: 127, time: DateTime(2021, 12, 7, 21)),
  ];

  List<BloodPressure> get bps {
    return [..._bps];
  }

  void addFood() {
    //_foods.add(value);
    notifyListeners();
  }
}
