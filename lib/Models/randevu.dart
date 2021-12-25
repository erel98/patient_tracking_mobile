import 'package:flutter/material.dart';

class Randevu extends ChangeNotifier {
  int id;
  DateTime date;
  String reminderText;

  Randevu({this.id, this.date, this.reminderText});
}
