import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/medicationInteraction.dart';
import 'package:patient_tracking/Services/medication_service.dart';

class MedicationInteractionProvider with ChangeNotifier {
  MedicationInteraction medInteraction = new MedicationInteraction();

  void getInteractionsById(int id) async {
    medInteraction = await MedicationService.getMedicationDetails(id);
    notifyListeners();
  }
}
