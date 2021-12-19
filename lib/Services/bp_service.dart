import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/bloodPressure.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Responses/API_Response.dart';

import '../Models/medicine.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

import 'http_service.dart';

class BloodPressureService {
  static String url = dotenv.env['API_URL'] + '/blood-pressures';
  static Future<bool> postBloodPressure(
      String systole, String diastole, String heartbeat) async {
    var success = false;

    Map<String, String> body = {};
    body['systole'] = systole;
    body['diastole'] = diastole;
    body['heartbeat'] = heartbeat;

    await HTTPService.httpPOST(url, body, appendToken: true)
        .then((API_Response response) {
      if (Global.successList.contains(response.status)) {
        success = true;
      }
    });
    return success;
  }

  static Future<List<BloodPressure>> getBloodPressures() async {
    List<BloodPressure> bloodPressures = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      print('39 ${response.body}');
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        var createdAt = DateTime.parse(element['created_at']);
        var diastole = (element['diastole'] as String).replaceAll(',', '.');
        var systole = (element['systole'] as String).replaceAll(',', '.');
        print('44: ${element['diastole']}');
        bloodPressures.add(
          BloodPressure(
              kValue: double.parse(diastole),
              bValue: double.parse(systole),
              heartBeat: int.parse(element['heartbeat']),
              time: createdAt),
        );
      });
    });
    return bloodPressures;
  }
}
