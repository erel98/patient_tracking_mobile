import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Models/question.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Responses/API_Response.dart';

import '../Models/medicine.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

import 'http_service.dart';

class QuestionService {
  static String url = dotenv.env['API_URL'] + '/my-questions';

  static Future<bool> postQuestion(String title, String body) async {
    var success = false;
    Map<String, String> postBody = {};
    postBody['subject'] = title;
    postBody['question'] = body;
    await HTTPService.httpPOST(url, postBody, appendToken: true)
        .then((API_Response response) {
      print('21: ${response.status}');
      print('22: ${response.message}');
      if (Global.successList.contains(response.status)) {
        success = true;
      }
    });
    return success;
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
          body: element['question'],
        );
        questions.add(currentQuestion);
      });
    });
    return questions;
  }
}
