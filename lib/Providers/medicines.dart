import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import '../Models/medicine.dart';
import './foods.dart';

class Medicines with ChangeNotifier {
  //burayı http get ile nasıl çekeceğiz?
  List<Medicine> _meds = [
    Medicine(
        1,
        'Aspirin',
        [''],
        'Aç karna',
        1,
        [
          Food(1, 'Greyfurt', null),
          Food(2, 'Portakal', null),
          Food(3, 'Muz', null),
        ],
        [],
        true),
    Medicine(
        2,
        'Minoset',
        ['Uyku', 'Baş dönmesi', 'Yorgunluk'],
        'Tok karna',
        1,
        [
          Food(1, 'Greyfurt', null),
          Food(3, 'Muz', null),
        ],
        [],
        false),
    Medicine(
        3,
        'Novaljin',
        ['İştahsızlık', 'Kaşıntı'],
        'Aç karna',
        2,
        [
          Food(3, 'Muz', null),
        ],
        [],
        true),
    Medicine(
        4,
        'Arveles',
        ['Baş ağrısı', 'Bulantı'],
        'Tok karna',
        1,
        [
          Food(1, 'Greyfurt', null),
          Food(2, 'Portakal', null),
        ],
        [],
        false),
  ];

  List<Medicine> get meds {
    return [..._meds];
  }

  void addMedicine() {
    //_meds.add(value);
    notifyListeners();
  }
}
