import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracking/Models/patient.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:patient_tracking/Responses/loginResponse.dart';
import 'package:patient_tracking/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../global.dart';

class PatientProvider with ChangeNotifier {
  static Patient currentPatient = Patient();

  static Future<bool> login(String phone, String password) async {
    bool success = false;

    String url = dotenv.env['API_URL'] + '/login';
    Map<String, String> body = {};
    body['phone_number'] = phone;
    body['password'] = password;

    await HTTPService.httpPOST(url, body).then((API_Response response) async {
      LoginResponse loginResponse =
          LoginResponse(token: response.data['token']);
      // print('15 ${loginResponse}');
      // print('16 ${response}');
      // print('17 ${response.status}');
      if (Global.successList.contains(response.status)) {
        success = true;
        // // print('24 ${loginResponse.}');

        // print('24 ${response.data.runtimeType}');
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('token', loginResponse.token);
        // print('24 ${loginResponse.token}');
      } else if (response.status == 422) {
        // print('422 döndü');
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

    // print(success.toString());
    return success;
  }

  static Future<bool> sendMe(String token) async {
    bool success = false;
    String url = dotenv.env['API_URL'] + '/me';

    await HTTPService.httpGET(url, appendToken: true)
        .then((http.Response response) {
      if (Global.successList.contains(response.statusCode)) {
        success = true;
        var jsonResponse = jsonDecode(response.body);
        currentPatient = Patient.fromJson(jsonResponse['data']);
      }
    });
    return success;
  }
}
