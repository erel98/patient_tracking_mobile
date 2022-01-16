import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/bloodGlucose.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class BloodGlucoseService {
  static String url = dotenv.env['API_URL'] + '/blood-glucoses';
  static Future<BloodGlucose> postBloodGlucose(BloodGlucose bg) async {
    BloodGlucose newBg;
    Map<String, String> body = {};
    body['value'] = bg.value.toString();
    await HTTPService.httpPOST(url, body, appendToken: true)
        .then((API_Response response) {
      var data = response.data;
      if (Global.successList.contains(response.status)) {
        newBg = BloodGlucose(
          id: data['id'],
          value: int.parse(data['value']),
          date: DateTime.now(),
        );
      }
    });
    return newBg;
  }

  static Future<List<BloodGlucose>> getBloodGlucoses() async {
    List<BloodGlucose> bgs = [];

    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);

      data.forEach((element) {
        BloodGlucose bg = BloodGlucose(
            id: element['id'],
            value: int.parse(
              element['value'],
            ),
            date: DateTime.parse(element['created_at']));
        bgs.add(bg);
      });
    });
    return bgs;
  }

  static Future<bool> removeBloodGlucose(int id) async {
    var success = false;
    await HTTPService.httpDELETE('$url/$id', appendToken: true)
        .then((API_Response response) {
      print('55: ${response.status}');
      if (Global.successList.contains(response.status)) {
        success = true;
      }
    });
    return success;
  }
}
