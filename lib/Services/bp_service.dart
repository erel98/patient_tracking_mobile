import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/bloodPressure.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class BloodPressureService {
  static String url = dotenv.env['API_URL'] + '/blood-pressures';
  static Future<BloodPressure> postBloodPressure(BloodPressure bp) async {
    BloodPressure newbp;

    Map<String, String> body = {};
    body['systole'] = bp.systole.toString();
    body['diastole'] = bp.diastole.toString();
    body['heartbeat'] = bp.heartBeat.toString();

    await HTTPService.httpPOST(url, body, appendToken: true)
        .then((API_Response response) {
      var data = response.data;
      if (Global.successList.contains(response.status)) {
        newbp = BloodPressure(
          id: data['id'],
          systole: double.parse(data['systole']),
          diastole: double.parse(data['diastole']),
          heartBeat: int.parse(data['heartbeat']),
          time: DateTime.now(),
        );
      }
    });
    return newbp;
  }

  static Future<List<BloodPressure>> getBloodPressures() async {
    List<BloodPressure> bloodPressures = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        var createdAt = DateTime.parse(element['created_at']);
        var diastole = (element['diastole'] as String).replaceAll(',', '.');
        var systole = (element['systole'] as String).replaceAll(',', '.');
        BloodPressure currentBp = new BloodPressure(
            id: element['id'],
            diastole: double.parse(diastole),
            systole: double.parse(systole),
            heartBeat: int.parse(element['heartbeat']),
            time: createdAt);
        bloodPressures.add(currentBp);
      });
    });
    return bloodPressures;
  }

  static Future<bool> removeBloodPressure(int id) async {
    var success = false;
    await HTTPService.httpDELETE('$url/$id', appendToken: true)
        .then((API_Response response) {
      if (Global.successList.contains(response.status)) {
        success = true;
      }
    });
    return success;
  }
}
