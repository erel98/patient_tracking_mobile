import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:patient_tracking/Responses/loginResponse.dart';
import 'package:patient_tracking/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PatientProvider {
  static Future<bool> login(String phone, String password) async {
    bool success = false;
    List<int> successList = [200, 201, 202, 203, 204, 205, 206];
    String url = dotenv.env['API_URL'] + '/login';
    Map<String, String> body = {};
    body['phone_number'] = phone;
    body['password'] = password;

    await HTTPService.httpPOST(url, body).then((API_Response response) async {
      LoginResponse loginResponse =
          LoginResponse(token: response.data.first['token']);
      print('15 ${loginResponse}');
      print('16 ${response}');
      print('17 ${response.status}');
      if (successList.contains(response.status)) {
        success = true;
        // print('24 ${loginResponse.}');

        print('24 ${response.data.runtimeType}');
        var prefs = await SharedPreferences.getInstance();
        prefs.setString('token', loginResponse.token);
        print('24 ${loginResponse.token}');
      } else if (response.status == 422) {
        print('422 döndü');
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

    print(success.toString());
    return success;
  }
}