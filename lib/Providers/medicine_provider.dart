import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:patient_tracking/Models/medicationVariantUser.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Services/medication_service.dart';
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
  List<MedicationVariant> medVariants = [];

  void getMedVariants(context) async {
    medVariants = await MedicationService.getMyMedications();
    notifyListeners();
  }

  void addMedicineVariant(MedicationVariant mv) {
    medVariants.add(mv);
    notifyListeners();
  }

  void update(MedicationVariant mv) {
    medVariants[medVariants.indexWhere((m) => m.id == mv.id)] = mv;
    notifyListeners();
  }

  void empty() {
    medVariants.clear();
  }
}
