import 'package:flutter/material.dart';
import 'package:patient_tracking/Services/question_service.dart';
import '../Models/question.dart';

class QuestionProvider extends ChangeNotifier {
  List<Question> questions = [];
  bool isLoading = true;
  void getQuestions(context) async {
    questions = await QuestionService.getMyQuestions();
    isLoading = false;
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

  Future<bool> removeQuestion(int id) async {
    var success = await QuestionService.removeQuestion(id);
    questions.removeWhere((element) => element.id == id);
    notifyListeners();
    return success;
  }
}
