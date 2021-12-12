import 'package:patient_tracking/Models/medicine.dart';

class GetMyMedicationsResponse {
  int id;
  int medicationId;
  String variant;
  //<pivot>
  int pivot_id;
  int userId;
  int medicationVariantId;
  bool isNotify;
  //</pivot>
  Medicine medicine;

  GetMyMedicationsResponse({
    this.id,
    this.medicationId,
    this.variant,
    this.pivot_id,
    this.userId,
    this.medicationVariantId,
    this.isNotify,
    this.medicine,
  });
}
