import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/place.dart';
import 'package:patient_tracking/Services/http_service.dart';
import 'package:http/http.dart' as http;
import '../global.dart';
import 'http_service.dart';

class WeatherService {
  static String getUrl = dotenv.env['API_URL'] + '/districts';
  static String postUrl = dotenv.env['API_URL'] + '/profile';

  static Future<List<Place>> getPlaces() async {
    List<Place> places = [];

    await HTTPService.httpGET(getUrl, appendToken: true)
        .then((http.Response response) {
      print('${response.body}');
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;
      var data = new List<Map<String, dynamic>>.from(jsonResponse['data']);
      data.forEach((element) {
        String name = element['name'];
        name = '${name[0]}${name.substring(1, name.length).toLowerCase()}';
        Place place = Place(id: element['id'], name: name);
        places.add(place);
      });
    });
    return places;
  }

  static Future<bool> putWeather(
      List<int> days, int districtId, String time) async {
    Map<String, dynamic> body = {};
    var success = false;
    body['days'] = days;
    body['district_id'] = districtId;
    body['time'] = time;
    await HTTPService.httpUPDATE(postUrl, body, appendToken: true)
        .then((http.Response response) {
      print('40 ${response.statusCode}');
      if (Global.successList.contains(response.statusCode)) {
        success = true;
      }
    });
    return success;
  }
}
