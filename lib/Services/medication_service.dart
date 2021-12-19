import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';

import '../Models/medicine.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

import 'http_service.dart';

class MedicationService {
  static Future<List<MedicationVariant>> getMyMedications() async {
    String url = dotenv.env['API_URL'] + '/my-medications';
    List<MedicationVariant> medicationVariants = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      // print('83 ${response.body}');
      if (Global.successList.contains(response.statusCode)) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        // print('24: ${jsonResponse['data'].runtimeType}');
        var jsonData = jsonResponse['data'];
        jsonData.forEach((data) {
          //for each user medication
          Medicine tempMedicine = new Medicine();
          MedicationVariantUser tempMvu = new MedicationVariantUser();
          MedicationVariant tempVariant = new MedicationVariant();

          tempMedicine.id = data['medication']['id'];
          tempMedicine.name = data['medication']['name'];
          tempMedicine.imageUrl = data['medication']['photo'];
          tempMedicine.stomach = data['medication']['empty_stomach'];

          tempMvu.id = data['pivot']['id'];
          tempMvu.isNotify =
              data['pivot']['is_notification_active']; //send this to update

          tempVariant.id = data['id'];
          tempVariant.name = data['variant'];
          tempVariant.medication = tempMedicine;
          tempVariant.medicationVariantUser = tempMvu;

          medicationVariants.add(tempVariant);
        });
      }
    });
    return medicationVariants;
  }

  static Future<bool> updateMedication(MedicationVariant mv) async {
    bool success = false;
    String url = dotenv.env['API_URL'] +
        '/my-medications/' +
        mv.medicationVariantUser.id.toString();
    var body = {'is_notification_active': mv.medicationVariantUser.isNotify};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);
    print('57 ${response.statusCode}');
    print('57 ${response.body}');

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }
}
