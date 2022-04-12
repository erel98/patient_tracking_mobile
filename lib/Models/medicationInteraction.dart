import 'package:patient_tracking/Models/medication.dart';

import 'food.dart';

class MedicationInteraction {
  int medId;
  String sideEffects;
  String usage;
  String foods;
  String effects;

  MedicationInteraction(
      {this.medId, this.sideEffects, this.usage, this.foods, this.effects});
}
