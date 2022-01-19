import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/history.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class HistoryService {
  static String url = dotenv.env['API_URL'] + '/medication-history';

  static Future<List<MedHistory>> getHistoryData() async {
    List<MedHistory> histories = [];

    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        MedHistory history = MedHistory(
          name: element['medication']['name'],
          imageUrl: element['medication']['photo'],
          isTaken: element['took_at'] != null,
          quantity: element['quantity'],
          takeTime: element['took_at'] != null
              ? DateTime.parse(
                  element['took_at'],
                )
              : DateTime.parse(element['take_time']),
        );
        histories.add(history);
      });
    });
    return histories;
  }
}
