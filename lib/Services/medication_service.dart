import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Models/calendarDay.dart';
import 'package:patient_tracking/Models/calendarEvent.dart';
import 'package:patient_tracking/Models/dailyMedication.dart';
import 'package:patient_tracking/Models/food.dart';
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
    print('başladı');
    //String url = dotenv.env['API_URL'] + '/my-medications';
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

        //print('71: ${day['events'].first.runtimeType}');

        List<Map<String, dynamic>> events =
            new List<Map<String, dynamic>>.from(day['events']);
        events.forEach((element) {
          print('79: ${element['tookAt']}');
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
          //print('88 daily med id: ${dailyMedication.id}');
          // dailyMedication.printDailyMed();
          CalendarEvent event = CalendarEvent(
            dailyMedication: dailyMedication,
            takeTime: DateTime.parse(element['takeTime']),
          );
          calendarEvents.add(event);
        });
        calendarDay.calendarEvents = calendarEvents;
        print('93: ${calendarDay.dayValue}');
        days.add(calendarDay);
      });
    });
    return days;
  }

  static Future<bool> updateMyMedication(
      MedicationUser mu, bool isNotify) async {
    bool success = false;
    print('gönderilen isNotify: $isNotify');
    String url = dotenv.env['API_URL'] + '/my-medications/' + mu.id.toString();
    var body = {'is_notification_active': isNotify};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);
    print('57 ${response.statusCode}');
    print('57 ${response.body}');

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }

  static Future<bool> updateDailyMedication(int id) async {
    print('118: $id');
    bool success = false;
    String url = '${dotenv.env['API_URL']}/daily-meds/$id';
    var body = {'took_at': DateFormat(dateFormat).format(DateTime.now())};
    var response = await HTTPService.httpUPDATE(url, body, appendToken: true);
    print('57 ${response.statusCode}');
    print('57 ${response.body}');

    if (Global.successList.contains(response.statusCode)) {
      success = true;
    }
    return success;
  }

  static Future<MedicationInteraction> getMedicationDetails(int id) async {
    MedicationInteraction interaction = new MedicationInteraction();
    interaction.foods = [];
    interaction.medications = [];
    interaction.sideEffects = [];

    await HTTPService.httpGET('$url/$id', appendToken: true)
        .then((http.Response response) {
      print('148 response: ${response.body}');
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new Map<String, List<dynamic>>.from(jsonResponse['data']);
      if (data['foods'] != null && data['foods'].isNotEmpty) {
        data['foods'].forEach((element) {
          Food food = new Food(
              id: element['id'],
              name: element['name'],
              imageUrl: element['image']);
          interaction.foods.add(food);
        });
      }
      if (data['side_effect'] != null) {
        print('side effects boş değil dedi');
        data['side_effect'].forEach((element) {
          interaction.sideEffects.add(element);
          print('eklenen side effect: $element');
        });
      }
      if (data['medications'] != null) {
        print('yasak meds boş değil dedi');
        data['medications'].forEach((element) {
          Medication forbMed = Medication(
              id: element['id'],
              name: element['name'],
              imageUrl: element['photo']);
          interaction.medications.add(forbMed);
        });
      }
    });

    return interaction;
  }
}
