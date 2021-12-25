import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/calendarEvent.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicationVariant.dart';
import '../Models/medication.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class MedicationService {
  static Future<List<MedicationUser>> getMyMedications() async {
    print('başladı');
    String url = dotenv.env['API_URL'] + '/my-medications';
    List<MedicationUser> medicationVariantUsers = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      // print('83 ${response.body}');
      if (Global.successList.contains(response.statusCode)) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        // print('24: ${jsonResponse['data'].runtimeType}');
        var jsonData =
            new List<Map<String, dynamic>>.from(jsonResponse['data']);
        jsonData.forEach((data) {
          //for each user medication
          Medication tempMedicine = new Medication();
          MedicationUser tempMu = new MedicationUser();
          MedicationVariant tempVariant = new MedicationVariant();

          tempMedicine.id = data['medication']['id'];
          //print('tempMedicine.id: ${tempMedicine.id}');
          tempMedicine.name = data['medication']['name'];
          // print('tempMedicine.name: ${tempMedicine.name}');
          tempMedicine.imageUrl =
              '${dotenv.env['IMAGE_URL']}${data['medication']['photo']}';
          print('tempMedicine.imageUrl: ${tempMedicine.imageUrl}');
          tempMedicine.stomach = data['medication']['empty_stomach'];
          // print('tempMedicine.stomach: ${tempMedicine.stomach}');

          tempVariant.id = data['variant']['id'];
          print('tempVariant.id: ${tempVariant.id}');
          tempVariant.name = data['variant']['name'];
          print('tempVariant.name: ${tempVariant.name}');
          tempVariant.medication = tempMedicine;

          tempMu.id = data['id'];
          tempMu.quantity = data['quantity'];
          tempMu.isNotify = data['is_notification_active'];
          tempMu.variant = tempVariant;
          tempMu.medication = tempMedicine;
          medicationVariantUsers.add(tempMu);
        });
      }
    });
    return medicationVariantUsers;
  }

  static Future<CalendarDay> getDailyMeds(int dayvalue) async {
    CalendarDay currDay = CalendarDay(dayValue: dayvalue);
    List<CalendarEvent> events = [];
    String url = dotenv.env['API_URL'] + '/daily-meds' + '?day=$dayvalue';
    HTTPService.httpGET(url, appendToken: true).then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        DailyMedication dailyMedication = DailyMedication(
            id: element['id'],
            medicationName: element['medication']['name'],
            variantName: element['medication']['variantName'],
            imageUrl:
                '${dotenv.env['IMAGE_URL']}${element['medication']['photo']}',
            quantity: element['quantity']);
        // dailyMedication.printDailyMed();
        CalendarEvent event = CalendarEvent(
          dailyMedication: dailyMedication,
          saat: element['hour'],
        );
        print('79: $event');
        events.add(event);
      });
    });
    events.forEach((element) {
      print('82: ' + element.dailyMedication.medicationName);
    });
    currDay.calendarEvents = events;
    return currDay;
  }

  static Future<bool> updateMedication(MedicationUser mu) async {
    bool success = false;
    String url = dotenv.env['API_URL'] + '/my-medications/' + mu.id.toString();
    var body = {'is_notification_active': mu.isNotify};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);
    print('57 ${response.statusCode}');
    print('57 ${response.body}');

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }
}
