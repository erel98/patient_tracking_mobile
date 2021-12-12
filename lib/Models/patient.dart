import './randevu.dart';

class Patient {
  int id;
  String fullName;
  int age;
  double weight;
  double height;
  String mobileNumber;
  List<Randevu> randevuList;

  Patient(
      {int id,
      int age,
      String fullName,
      double weight,
      double height,
      String mobileNumber,
      List<Randevu> randevuList}) {
    this.id = id;
    this.fullName = fullName;
    this.age = age;
    this.weight = weight;
    this.height = height;
    this.mobileNumber = mobileNumber;
    this.randevuList = randevuList;
  }

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      fullName: json['name'],
      weight: (json['weight'] as int).toDouble(),
      height: (json['height'] as int).toDouble(),
      mobileNumber: json['phone_number'],
    );
  }
}
