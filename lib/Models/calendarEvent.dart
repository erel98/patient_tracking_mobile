import 'package:patient_tracking/Models/medicineVariant.dart';

import 'medicine.dart';

class CalendarEvent {
  int id;
  double saat; //0-48
  List<MedicationVariant> medsToTake; //aynı saatte alınabilecek ilaçlar

  CalendarEvent(int id, double saat, List<MedicationVariant> medsToTake) {
    this.id = id;
    this.saat = saat;
    this.medsToTake = medsToTake;
  }
}
