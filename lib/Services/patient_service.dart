import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracking/Models/patient.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:patient_tracking/Responses/loginResponse.dart';
import 'package:patient_tracking/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global.dart';

class PatientService with ChangeNotifier {
  static Patient currentPatient = Patient();

  static Future<bool> login(String phone, String password) async {
    bool success = false;
    var prefs = await SharedPreferences.getInstance();
    String fcmToken = prefs.getString('fcm_token');
    String url = dotenv.env['API_URL'] + '/login';
    Map<String, String> body = {};
    body['phone_number'] = phone;
    body['password'] = password;
    body['fcm_token'] = fcmToken;

    await HTTPService.httpPOST(url, body).then((API_Response response) async {
      LoginResponse loginResponse =
          LoginResponse(token: response.data['token']);
      if (Global.successList.contains(response.status)) {
        success = true;

        var prefs = await SharedPreferences.getInstance();
        prefs.setString('token', loginResponse.token);
        prefs.setBool('isloggedin', true);
      } else if (response.status == 422) {
        Fluttertoast.showToast(
            msg: 'Telefon numarası ya da şifre hatalı',
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.white,
            textColor: Colors.green,
            fontSize: 16.0);
      } else {
        Fluttertoast.showToast(msg: 'Hay aksi! Bir şeyler ters gitti');
      }
    });

    return success;
  }

  static Future<bool> sendMe(String token) async {
    bool success = false;
    String url = dotenv.env['API_URL'] + '/me';
    var prefs = await SharedPreferences.getInstance();

    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      if (Global.successList.contains(response.statusCode)) {
        success = true;
        var jsonResponse = jsonDecode(response.body);
        currentPatient = Patient.fromJson(jsonResponse['data']);
        prefs.setString('name', currentPatient.fullName);
        prefs.setDouble('weight', currentPatient.weight);
        prefs.setInt('height', currentPatient.height);
      }
    });
    return success;
  }

  static Future<bool> updateMe({String name, int height, double weight}) async {
    bool success = false;
    String url = '${dotenv.env['API_URL']}/profile';
    Map<String, dynamic> body = {};
    if (name != null) body['name'] = name;
    if (height != null) body['height'] = height;
    if (weight != null) body['weight'] = weight;
    var prefs = await SharedPreferences.getInstance();
    await HTTPService.httpUPDATE(url, body, appendToken: true)
        .then((http.Response response) {
      if (Global.successList.contains(response.statusCode)) {
        success = true;
        prefs.setString('name', name);
        prefs.setDouble('weight', weight);
        prefs.setInt('height', height);
      } else {
        Fluttertoast.showToast(msg: 'Hay aksi! Bir şeyler ters gitti.');
      }
    });
    return success;
  }
}
