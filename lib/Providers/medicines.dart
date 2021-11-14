import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import '../Models/medicine.dart';
import './foods.dart';

class Medicines with ChangeNotifier {
  //burayı http get ile nasıl çekeceğiz?
  List<Medicine> _meds = [
    Medicine(
        id: 1,
        name: 'Aspirin',
        sideEffects: [''],
        stomach: 'Aç karna',
        quantity: 1,
        forbiddenFoods: [
          Food(1, 'Greyfurt', null),
          Food(2, 'Portakal', null),
          Food(3, 'Muz', null),
        ],
        forbiddenMeds: [],
        isNotificationActive: true,
        unit: 'Tablet'),
    Medicine(
      id: 2,
      name: 'Minoset',
      sideEffects: ['Uyku', 'Baş dönmesi', 'Yorgunluk'],
      stomach: 'Tok karna',
      quantity: 1,
      forbiddenFoods: [
        Food(1, 'Greyfurt', null),
        Food(3, 'Muz', null),
      ],
      forbiddenMeds: [],
      isNotificationActive: false,
      unit: 'Tablet',
    ),
    Medicine(
      id: 3,
      name: 'Novaljin',
      sideEffects: ['İştahsızlık', 'Kaşıntı'],
      stomach: 'Aç karna',
      quantity: 2,
      forbiddenFoods: [
        Food(3, 'Muz', null),
      ],
      forbiddenMeds: [],
      isNotificationActive: true,
      unit: 'Tablet',
    ),
    Medicine(
      id: 4,
      name: 'Arveles',
      sideEffects: ['Baş ağrısı', 'Bulantı'],
      stomach: 'Tok karna',
      quantity: 1,
      forbiddenFoods: [
        Food(1, 'Greyfurt', null),
        Food(2, 'Portakal', null),
      ],
      forbiddenMeds: [],
      isNotificationActive: false,
      unit: 'Tablet',
    ),
  ];

  List<Medicine> get meds {
    return [..._meds];
  }

  void addMedicine() {
    //_meds.add(value);
    notifyListeners();
  }
}
