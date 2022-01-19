import 'food.dart';

class Medication {
  int id;
  String name;
  String imageUrl;
  List<String> sideEffects;
  bool stomach;
  List<Food> forbiddenFoods;
  List<Medication> forbiddenMeds;

  Medication({
    int id,
    String name,
    String imageUrl,
    List<String> sideEffects,
    bool stomach,
    List<Food> forbiddenFoods,
    List<Medication> forbiddenMeds,
  }) {
    this.id = id;
    this.name = name;
    this.imageUrl = imageUrl;
    this.sideEffects = sideEffects;
    this.stomach = stomach;
    this.forbiddenFoods = forbiddenFoods;
    this.forbiddenMeds = forbiddenMeds;
  }

  factory Medication.fromJson(Map<String, dynamic> json) {
    return Medication(
      id: json['id'],
      name: json['name'],
      imageUrl: json['photo'],
      stomach: json['empty_stomach'],
    );
  }
}
