import './randevu.dart';

class Patient {
  int id;
  String fullName;
  int age;
  double weight;
  String mobileNumber;
  List<Randevu> randevuList;

  Patient(
      [int id,
      int age,
      double weight,
      String mobileNumber,
      List<Randevu> randevuList]) {
    this.id = id;
    this.fullName = fullName;
    this.age = age;
    this.weight = weight;
    this.mobileNumber = mobileNumber;
    this.randevuList = randevuList;
  }
}
