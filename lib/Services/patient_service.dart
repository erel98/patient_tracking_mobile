import '../Models/patient.dart';
import '../global.dart';
import 'package:http/http.dart' as http;

class PatientService {
  static Future<Patient> getPatient(String id) async {
    var url = '${await Global.getUrl()}/$id';
    var patient = Patient();
  }

  static Future<bool> updatePatient(Patient patient) async {}
}
