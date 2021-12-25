import 'package:flutter/material.dart';
import 'package:patient_tracking/Services/randevu_service.dart';
import '../Models/randevu.dart';

class RandevuProvider with ChangeNotifier {
  List<Randevu> randevuList = [];
  var isLoading = true;
  void getRandevusList(context) async {
    randevuList = await RandevuService.getRandevus();
    isLoading = false;
    notifyListeners();
  }

  void addRandevu(Randevu randevu) async {
    Randevu newRandevu = await RandevuService.postRandevu(randevu);
    print('16 id: ${newRandevu.id} name: ${newRandevu.reminderText}');
    if (newRandevu.id != null) {
      randevuList.add(newRandevu);
      notifyListeners();
    }
  }

  Future<bool> removeRandevu(int id) async {
    var success = await RandevuService.deleteRandevu(id);
    if (success) {
      randevuList.removeWhere((element) => element.id == id);
      notifyListeners();
    }
    return success;
  }

  void update(Randevu randevu) {
    randevuList[randevuList.indexWhere((m) => m.id == randevu.id)] = randevu;
    notifyListeners();
  }

  void empty() {
    randevuList.clear();
  }
}
