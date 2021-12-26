import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/place.dart';
import 'package:patient_tracking/Services/weather_service.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> places = [];

  void getPlaces() async {
    places = await WeatherService.getPlaces();
    notifyListeners();
  }
}
