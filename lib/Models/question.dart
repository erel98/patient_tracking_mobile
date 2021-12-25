import 'package:flutter/material.dart';

class Question extends ChangeNotifier {
  int id;
  String subject;
  String question;
  String answer;
  bool isExpanded;

  Question(
      {int id,
      String title,
      String body,
      String answer,
      bool isExpanded = false}) {
    this.id = id;
    this.subject = title;
    this.question = body;
    this.answer = answer;
    this.isExpanded = isExpanded;
  }
}
