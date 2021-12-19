import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import '../Models/medicine.dart';
import '../global.dart';
import 'food_provider.dart';
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
  List<MedicationVariant> _medVariants = [];

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
