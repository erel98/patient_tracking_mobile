import 'medicine.dart';

class CalendarEvent {
  int id;
  double saat; //0-48
  List<Medicine> medsToTake; //aynı saatte alınabilecek ilaçlar

  CalendarEvent(int id, double saat, List<Medicine> medsToTake) {
    this.id = id;
    this.saat = saat;
    this.medsToTake = medsToTake;
  }
}
