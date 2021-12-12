import 'package:patient_tracking/Models/medicationVariantUser.dart';

import 'medicine.dart';

class MedicationVariant {
  int id;
  String name;
  Medicine medication;
  MedicationVariantUser medicationVariantUser;

  MedicationVariant(
      {this.id, this.name, this.medication, this.medicationVariantUser});
}
