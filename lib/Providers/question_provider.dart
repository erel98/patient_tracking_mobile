import 'package:flutter/material.dart';
import '../Models/question.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class QuestionProvider extends ChangeNotifier {
  List<Question> _questions = [];

  List<Question> get questions {
    return _questions;
  }

  void addQuestion(Question question) {
    _questions.add(question);
    notifyListeners();
  }

  void update(Question question) {
    _questions[_questions.indexWhere((m) => m.id == question.id)] = question;
    notifyListeners();
  }

  void empty() {
    _questions.clear();
  }
}
