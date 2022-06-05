import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/otherMedication.dart';

import '../global.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class OtherMedicationService {
  static String url = dotenv.env['API_URL'] + '/my-other-medications';

  static Future<List<OtherMedication>> getOtherMedications() async {
    List<OtherMedication> otherMeds = [];

    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var jsonData = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      jsonData.forEach((data) {
        OtherMedication otherMedication = new OtherMedication();
        otherMedication.id = data['id'];
        otherMedication.name = data['medication']['name'];
        otherMedication.isNotify = data['is_notification_active'];
        otherMedication.description = data['medication']['description'];
        otherMedication.imageUrl =
            dotenv.env['IMAGE_URL'] + data['medication']['photo'];

        otherMeds.add(otherMedication);
      });
    });
    return otherMeds;
  }

  static Future<bool> updateMyOtherMedication(
      OtherMedication om, bool isNotify) async {
    bool success = false;
    String url =
        dotenv.env['API_URL'] + '/my-other-medications/' + om.id.toString();
    var body = {'is_notification_active': isNotify};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }
}
