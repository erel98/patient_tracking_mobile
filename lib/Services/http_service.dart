import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HTTPService {
  static Future<Response> httpGET(String url,
      {bool appendToken = false}) async {
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
        return response;
      });
    } catch (error) {
      throw (error);
    }

    return response;
  }

  static Future<API_Response> httpPOST(String url, Object body,
      {bool appendToken = false}) async {
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
      return await http
          .post(uri, headers: headers, body: jsonEncode(body))
          .then((http.Response response) {
        // print('52 ${response.body}');
        Map<String, dynamic> decodedResponse = jsonDecode(response.body);
        List<dynamic> data = decodedResponse['data'] ?? null;
        var apiResponse = API_Response(
            data: data,
            error: decodedResponse['error'] ?? null,
            message: decodedResponse['message'],
            status: response.statusCode);
        return apiResponse;
      });
    } catch (error) {
      throw (error);
    }
  }

  static Future<Response> httpUPDATE(String url, Object body,
      {bool appendToken = false}) async {
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
        return response;
      });
    } catch (error) {
      throw (error);
    }
  }
}
