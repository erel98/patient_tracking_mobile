import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import '../Models/medicine.dart';
import '../global.dart';
import './foods.dart';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:patient_tracking/Models/patient.dart';
import 'package:patient_tracking/Responses/API_Response.dart';
import 'package:patient_tracking/Responses/loginResponse.dart';
import 'package:patient_tracking/Services/http_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MedicineProvider extends ChangeNotifier {
  static var aspirin = Medicine(
      id: 1,
      name: 'Aspirin',
      sideEffects: [''],
      stomach: true,
      quantity: 1,
      forbiddenFoods: [
        Food(1, 'Greyfurt', null),
        Food(2, 'Portakal', null),
        Food(3, 'Muz', null),
      ],
      forbiddenMeds: [],
      isNotificationActive: true,
      unit: 'Tablet');
  static var minoset = Medicine(
    id: 2,
    name: 'Minoset',
    sideEffects: ['Uyku', 'Baş dönmesi', 'Yorgunluk'],
    stomach: false,
    quantity: 1,
    forbiddenFoods: [
      Food(1, 'Greyfurt', null),
      Food(3, 'Muz', null),
    ],
    forbiddenMeds: [],
    isNotificationActive: false,
    unit: 'Tablet',
  );
  static var novaljin = Medicine(
    id: 3,
    name: 'Novaljin',
    sideEffects: ['İştahsızlık', 'Kaşıntı'],
    stomach: true,
    quantity: 2,
    forbiddenFoods: [
      Food(3, 'Muz', null),
    ],
    forbiddenMeds: [minoset, arveles],
    isNotificationActive: true,
    unit: 'Tablet',
  );
  static var arveles = Medicine(
    id: 4,
    name: 'Arveles',
    sideEffects: ['Baş ağrısı', 'Bulantı'],
    stomach: false,
    quantity: 1,
    forbiddenFoods: [
      Food(1, 'Greyfurt', null),
      Food(2, 'Portakal', null),
    ],
    forbiddenMeds: [],
    isNotificationActive: false,
    unit: 'Tablet',
  );
  List<Medicine> _meds = [aspirin, minoset, novaljin, arveles];
  final List<MedicationVariant> _medVariants = [];

  List<MedicationVariant> get medVariants {
    return _medVariants;
  }

  void addMedicineVariant(MedicationVariant mv) {
    _medVariants.add(mv);
    notifyListeners();
  }

  void update(MedicationVariant mv) {
    _medVariants[_medVariants.indexWhere((m) => m.id == mv.id)] = mv;
    notifyListeners();
  }

  void empty() {
    _medVariants.clear();
  }
}
