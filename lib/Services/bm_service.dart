import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/bloodMedicine.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class BloodMedicineService {
  static String url = dotenv.env['API_URL'] + '/blood-medicines';
  static Future<List<BloodMedicine>> getBloodMedicines() async {
    List<BloodMedicine> bms = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        int tempId = element['medication']['id'];
        String tempName = element['medication']['name'];
        List<dynamic> values =
            new List<Map<String, dynamic>>.from((element['data']));

        values.forEach((value) {
          BloodMedicine bm = BloodMedicine(
            medId: tempId,
            medName: tempName,
            createdatetime: DateTime.parse(value['created_at']),
            value: int.parse(
              value['value'],
            ),
          );
          bms.add(bm);
        });
      });
    });
    return bms;
  }
}
