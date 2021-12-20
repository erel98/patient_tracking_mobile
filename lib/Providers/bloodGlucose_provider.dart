import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/bloodGlucose.dart';
import 'package:patient_tracking/Services/bg_service.dart';

class BloodGlucoseProvider with ChangeNotifier {
  List<BloodGlucose> bgs = [];

  void getBloodGlucoses() async {
    bgs = await BloodGlucoseService.getBloodGlucoses();
    notifyListeners();
  }

  void addBloodGlucose(BloodGlucose bg) async {
    var newbg = await BloodGlucoseService.postBloodGlucose(bg);
    bgs.add(newbg);
    notifyListeners();
  }
}
