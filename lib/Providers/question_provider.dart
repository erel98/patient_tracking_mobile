import 'package:flutter/material.dart';
import 'package:patient_tracking/Services/question_service.dart';
import '../Models/question.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> questions = [];

  void getQuestions(context) async {
    questions = await QuestionService.getMyQuestions();
    notifyListeners();
  }

  void addQuestion(Question question) async {
    var newQuestion = await QuestionService.postQuestion(question);
    questions.add(newQuestion);
    notifyListeners();
  }

  void update(Question question) {
    questions[questions.indexWhere((m) => m.id == question.id)] = question;
    notifyListeners();
  }

  void empty() {
    questions.clear();
  }
}
