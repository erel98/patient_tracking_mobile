import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/randevu.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:patient_tracking/constraints.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'http_service.dart';

class RandevuService {
  static String url = dotenv.env['API_URL'] + '/my-reminders';
  static Future<Randevu> postRandevu(Randevu randevu) async {
    Randevu newRandevu;
    var randevuDate = randevu.date;
    var reminderText = randevu.reminderText;
    final DateFormat formatter = DateFormat(dateFormat);
    final String formatted = formatter.format(randevuDate);
    print(formatted);
    Map<String, dynamic> body = {};
    body['reminder'] = reminderText;
    body['reminder_time'] = formatted;
    await HTTPService.httpPOST(url, body, appendToken: true)
        .then((API_Response response) {
      var data = response.data;
      print('28: ${response.message}');
      if (Global.successList.contains(response.status)) {
        DateTime date = DateTime.parse(data['reminder_time']);
        newRandevu =
            Randevu(id: data['id'], date: date, reminderText: data['reminder']);
      }
    });
    return newRandevu;
  }

  static Future<List<Randevu>> getRandevus() async {
    print('get randevu çalıştı');
    List<Randevu> randevus = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      //print('39: ${response.body}');
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        //print('42: ${element['date']}');
        DateTime date = DateTime.parse(element['reminder_time']);
        randevus.add(
          Randevu(
            id: element['id'],
            date: date,
            reminderText: element['reminder'],
          ),
        );
      });
    });
    return randevus;
  }

  static Future<bool> deleteRandevu(int id) async {
    String deleteUrl = '$url/$id';
    print('deleteurl: $deleteUrl');
    bool success = false;
    print('$id idli randevu siliniyor');
    await HTTPService.httpDELETE(deleteUrl, appendToken: true)
        .then((API_Response response) {
      print('65: ${response.status}');
      if (Global.successList.contains(response.status)) {
        success = true;
      }
    });
    return success;
  }
}
