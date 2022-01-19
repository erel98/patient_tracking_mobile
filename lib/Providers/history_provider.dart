import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/history.dart';
import 'package:patient_tracking/Services/history_service.dart';

class HistoryProvider with ChangeNotifier {
  List<MedHistory> histories = [];

  Future<void> getHistories() async {
    histories = await HistoryService.getHistoryData();
    notifyListeners();
  }
}
