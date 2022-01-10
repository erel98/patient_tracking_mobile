import 'package:flutter/material.dart';
import '../Models/food.dart';

class FoodProvider with ChangeNotifier {
  List<Food> _foods = [];

  List<Food> get foods {
    return [..._foods];
  }

  void addFood() {
    //_foods.add(value);
    notifyListeners();
  }
}
