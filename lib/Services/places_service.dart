import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/Models/place.dart';
import 'package:patient_tracking/Services/http_service.dart';
import 'package:http/http.dart' as http;
import 'http_service.dart';

class PlaceService {
  static String baseUrl = dotenv.env['API_URL'] + '/districts';

  static Future<List<Place>> getPlaces() async {
    List<Place> places = [];

    await HTTPService.httpGET(baseUrl, appendToken: true)
        .then((http.Response response) {
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
}
