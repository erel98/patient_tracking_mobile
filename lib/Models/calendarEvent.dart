import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/medicationVariant.dart';

class CalendarEvent {
  int id;
  int saat; //0-48
  DailyMedication dailyMedication; //aynı saatte alınabilecek ilaçlar

  CalendarEvent({this.id, this.saat, this.dailyMedication});
}
