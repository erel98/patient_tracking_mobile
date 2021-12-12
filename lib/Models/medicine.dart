import 'food.dart';

class Medicine {
  int id;
  String name;
  String imageUrl;
  List<String> sideEffects;
  bool stomach;
  int quantity;
  List<Food> forbiddenFoods;
  List<Medicine> forbiddenMeds;
  bool isNotificationActive;
  String unit;

  Medicine(
      {int id,
      String name,
      String imageUrl,
      List<String> sideEffects,
      bool stomach,
      int quantity,
      List<Food> forbiddenFoods,
      List<Medicine> forbiddenMeds,
      bool isNotificationActive,
      String unit}) {
    this.id = id;
    this.name = name;
    this.imageUrl = imageUrl;
    this.sideEffects = sideEffects;
    this.stomach = stomach;
    this.quantity = quantity;
    this.forbiddenFoods = forbiddenFoods;
    this.forbiddenMeds = forbiddenMeds;
    this.isNotificationActive = isNotificationActive;
    this.unit = unit;
  }
  void display() {
    // print('id: $id\nName: $name\nSide Effect: $sideEffects');
  }

  factory Medicine.fromJson(Map<String, dynamic> json) {
    return Medicine(
      id: json['id'],
      name: json['name'],
      imageUrl: json['photo'],
      stomach: json['empty_stomach'],
    );
  }
}
