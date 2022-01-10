import 'package:patient_tracking/Models/medication.dart';

import 'food.dart';

class MedicationInteraction {
  int medId;
  List<String> sideEffects;
  List<Food> foods;
  List<Medication> medications;

  MedicationInteraction(
      {this.medId, this.sideEffects, this.foods, this.medications});
}
