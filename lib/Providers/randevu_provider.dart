import 'package:flutter/material.dart';
import '../Models/randevu.dart';

class RandevuProvider with ChangeNotifier {
  List<Randevu> _randevus = [];

  List<Randevu> get randevus {
    return [..._randevus];
  }

  void addMedicine() {
    //_meds.add(value);
    notifyListeners();
  }
}
