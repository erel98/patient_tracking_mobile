import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Models/question.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class QuestionService {
  static String url = dotenv.env['API_URL'] + '/my-questions';

  static Future<Question> postQuestion(Question question) async {
    var newQuestion;
    var title = question.subject;
    var body = question.question;
    Map<String, String> postBody = {};
    postBody['subject'] = title;
    postBody['question'] = body;
    await HTTPService.httpPOST(url, postBody, appendToken: true)
        .then((API_Response response) {
      print('21: ${response.status}');
      print('22: ${response.data}');
      print('23: ${response.message}');
      var data = response.data;
      newQuestion = Question(
          id: data['id'], title: data['subject'], body: data['question']);
      if (Global.successList.contains(response.status)) {
        newQuestion = Question(
            id: data['id'], title: data['subject'], body: data['question']);
        Fluttertoast.showToast(msg: 'Sorunuz başarıyla gönderildi.');
      } else {
        Fluttertoast.showToast(msg: 'Hay aksi! Bir şeyler ters gitti');
      }
    });
    return newQuestion;
  }

  static Future<List<Question>> getMyQuestions() async {
    List<Question> questions = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      //print('37: ${response.body}');
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      //List<dynamic> data = jsonResponse['data'];
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);

      data.forEach((element) {
        Question currentQuestion = new Question(
          id: element['id'],
          title: element['subject'],
          answer: element['answer'] ?? null,
          body: element['question'],
        );
        questions.add(currentQuestion);
      });
    });
    return questions;
  }
}
