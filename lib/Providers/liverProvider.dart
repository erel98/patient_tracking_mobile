import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/history.dart';
import 'package:patient_tracking/Models/liverInfo.dart';
import 'package:patient_tracking/Services/liver_service.dart';

class LiverProvider with ChangeNotifier {
  LiverInfo info;

  Future<void> getLiverInfo() async {
    info = await LiverService.getLiverInfo();
    notifyListeners();
  }
}
