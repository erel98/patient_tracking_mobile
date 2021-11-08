import 'package:flutter/material.dart';
import '../Models/food.dart';

class Foods with ChangeNotifier {
  List<Food> _foods = [
    Food(1, 'Greyfurt', null),
    Food(2, 'Portakal', null),
    Food(3, 'Muz', null),
    Food(4, 'Elma', null),
  ];

  List<Food> get foods {
    return [..._foods];
  }

  void addFood() {
    //_foods.add(value);
    notifyListeners();
  }
}
