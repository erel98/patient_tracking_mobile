import 'dart:convert';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HTTPService {
  static Future<Response> httpGET(String url,
      {bool appendToken = false}) async {
    EasyLoading.show(status: 'yükleniyor...');
    var uri = Uri.parse(url);
    String token;
    var prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (appendToken) {
      token = prefs.getString('token');
      headers.putIfAbsent('Authorization', () => 'Bearer ' + token);
    }
    var response;
    try {
      response =
          await http.get(uri, headers: headers).then((http.Response response) {
        EasyLoading.dismiss();
        return response;
      });
    } catch (error) {
      EasyLoading.dismiss();
      throw (error);
    }

    return response;
  }

  static Future<API_Response> httpPOST(String url, Object body,
      {bool appendToken = false}) async {
    EasyLoading.show(status: 'yükleniyor...');
    var prefs = await SharedPreferences.getInstance();
    var uri = Uri.parse(url);
    String token;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if (appendToken) {
      token = prefs.getString('token');
      headers.putIfAbsent('Authorization', () => 'Bearer ' + token);
    }
    try {
      var response = await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .then((http.Response response) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        Map<String, dynamic> data = decodedResponse['data'] ?? null;
        var apiResponse = API_Response(
            data: data,
            error: decodedResponse['error'] ?? null,
            message: decodedResponse['message'],
            status: response.statusCode);
        return apiResponse;
      });
      EasyLoading.dismiss();
      return response;
    } catch (error, stacktrace) {
      EasyLoading.dismiss();
      print(stacktrace);
      throw (error);
    }
  }

  static Future<Response> httpUPDATE(String url, Object body,
      {bool appendToken = false}) async {
    EasyLoading.show(status: 'yükleniyor...');

    var uri = Uri.parse(url);
    String token;
    var prefs = await SharedPreferences.getInstance();

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
    if (appendToken) {
      token = prefs.getString('token');
      headers.putIfAbsent('Authorization', () => 'Bearer ' + token);
    }
    try {
      return await http
          .put(uri, headers: headers, body: jsonEncode(body))
          .then((http.Response response) {
        EasyLoading.dismiss();
        return response;
      });
    } catch (error) {
      EasyLoading.dismiss();
      throw (error);
    }
  }

  static Future<API_Response> httpDELETE(String url,
      {bool appendToken = false}) async {
    EasyLoading.show(status: 'yükleniyor...');
    var uri = Uri.parse(url);
    String token;
    var prefs = await SharedPreferences.getInstance();
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };

    if (appendToken) {
      token = prefs.getString('token');
      headers.putIfAbsent('Authorization', () => 'Bearer ' + token);
    }

    try {
      var response = await http
          .delete(uri, headers: headers)
          .then((http.Response response) {
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        Map<String, dynamic> data = decodedResponse['data'] ?? null;
        var apiResponse = API_Response(
            data: data,
            error: decodedResponse['error'] ?? null,
            message: decodedResponse['message'],
            status: response.statusCode);
        EasyLoading.dismiss();
        return apiResponse;
      });
      EasyLoading.dismiss();
      return response;
    } catch (error) {
      EasyLoading.dismiss();
      throw (error);
    }
  }
}
