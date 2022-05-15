import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/calendarEvent.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/medicationInteraction.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicationVariant.dart';
import 'package:patient_tracking/constraints.dart';
import '../Models/medication.dart';
import '../global.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class MedicationService {
  static String url = dotenv.env['API_URL'] + '/my-medications';
  static Future<List<MedicationUser>> getMyMedications() async {
    List<MedicationUser> medicationVariantUsers = [];
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      if (Global.successList.contains(response.statusCode)) {
        var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
        var jsonData =
            new List<Map<String, dynamic>>.from(jsonResponse['data']);
        jsonData.forEach((data) {
          //for each user medication
          Medication tempMedicine = new Medication();
          MedicationUser tempMu = new MedicationUser();
          MedicationVariant tempVariant = new MedicationVariant();

          tempMedicine.id = data['medication']['id'];
          tempMedicine.name = data['medication']['name'];
          tempMedicine.imageUrl =
              '${dotenv.env['IMAGE_URL']}${data['medication']['photo']}';
          tempMedicine.stomach = data['medication']['empty_stomach'];

          tempVariant.id = data['variant']['id'];
          tempVariant.name = data['variant']['name'];
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

  static Future<List<CalendarDay>> getDailyMeds() async {
    List<CalendarDay> days = [];
    String url = dotenv.env['API_URL'] + '/daily-meds';
    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((day) {
        List<CalendarEvent> calendarEvents = [];
        CalendarDay calendarDay = CalendarDay(dayValue: day['day']);
        List<Map<String, dynamic>> events =
            new List<Map<String, dynamic>>.from(day['events']);
        events.forEach((element) {
          DailyMedication dailyMedication = DailyMedication(
            id: element['id'],
            medicationName: element['medication']['name'],
            variantName: element['medication']['variantName'],
            imageUrl:
                '${dotenv.env['IMAGE_URL']}${element['medication']['photo']}',
            quantity: element['quantity'],
            tookAt: element['tookAt'] != null
                ? DateTime.parse(element['tookAt'])
                : null,
          );
          CalendarEvent event = CalendarEvent(
            dailyMedication: dailyMedication,
            takeTime: DateTime.parse(element['takeTime']),
          );
          calendarEvents.add(event);
        });
        calendarDay.calendarEvents = calendarEvents;
        days.add(calendarDay);
      });
    });
    return days;
  }

  static Future<bool> updateMyMedication(
      MedicationUser mu, bool isNotify) async {
    bool success = false;
    String url = dotenv.env['API_URL'] + '/my-medications/' + mu.id.toString();
    var body = {'is_notification_active': isNotify};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }

  static Future<bool> updateDailyMedication(int id) async {
    bool success = false;
    String url = '${dotenv.env['API_URL']}/daily-meds/$id';
    var body = {'took_at': DateFormat(dateFormat).format(DateTime.now())};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }

  static Future<MedicationInteraction> getMedicationDetails(int id) async {
    MedicationInteraction interaction = new MedicationInteraction();

    await HTTPService.httpGET('$url/$id', appendToken: true)
        .then((http.Response response) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new Map<String, dynamic>.from(jsonResponse['data']);
      print(response.body);

      interaction.effects = data['effects'];
      interaction.usage = data['usage'];
      interaction.sideEffects = data['side_effects'];
      interaction.foods = data['food_interactions'];
      interaction.medToMedInteraction = data['medication_interactions'];

      if (interaction.effects != null)
        interaction.effects = interaction.effects
            .replaceAll('<li></li>', '')
            .replaceAll('<li>', '<li style="font-size:20px;line-height:20px;">')
            .replaceAll('</li>', '<br></li>');

      if (interaction.usage != null)
        interaction.usage = interaction.usage
            .replaceAll('<li></li>', '')
            .replaceAll('<li>', '<li style="font-size:20px;line-height:20px;">')
            .replaceAll('</li>', '<br></li>');

      if (interaction.sideEffects != null)
        interaction.sideEffects = interaction.sideEffects
            .replaceAll('<li></li>', '')
            .replaceAll('<li>', '<li style="font-size:20px;line-height:20px;">')
            .replaceAll('</li>', '<br></li>');
      if (interaction.foods != null)
        interaction.foods = interaction.foods
            .replaceAll('<li></li>', '')
            .replaceAll('<li>', '<li style="font-size:20px;line-height:20px;">')
            .replaceAll('</li>', '<br></li>');
      if (interaction.medToMedInteraction != null)
        interaction.medToMedInteraction = interaction.medToMedInteraction
            .replaceAll('<li></li>', '')
            .replaceAll('<li>', '<li style="font-size:20px;line-height:20px;">')
            .replaceAll('</li>', '<br></li>');
    });

    return interaction;
  }
}
