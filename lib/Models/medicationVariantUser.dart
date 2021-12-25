import 'package:patient_tracking/Models/medicationVariant.dart';

import 'medication.dart';

class MedicationUser {
  int id;
  bool isNotify;
  String quantity;
  MedicationVariant variant;
  Medication medication;

  MedicationUser({
    this.id,
    this.isNotify,
    this.quantity,
    this.variant,
    this.medication,
  });
}
