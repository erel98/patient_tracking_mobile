import 'package:flutter/material.dart';

class Question extends ChangeNotifier {
  int id;
  String title;
  String body;
  String answer;
  bool isExpanded;

  Question(
      {int id,
      String title,
      String body,
      String answer,
      bool isExpanded = false}) {
    this.id = id;
    this.title = title;
    this.body = body;
    this.answer = answer;
    this.isExpanded = isExpanded;
  }
}
