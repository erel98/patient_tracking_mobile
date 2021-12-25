import 'package:patient_tracking/Models/calendarEvent.dart';

class CalendarDay {
  int id;
  int dayValue; //0-6
  List<CalendarEvent> calendarEvents; //ekranda gözükecek eventler

  CalendarDay({int id, int dayValue, List<CalendarEvent> calendarEvents}) {
    this.id = id;
    this.dayValue = dayValue;
    this.calendarEvents = calendarEvents;
  }
}
