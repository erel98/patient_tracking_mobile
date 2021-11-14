import 'food.dart';

class Medicine {
  int id;
  String name;
  List<String> sideEffects;
  String stomach;
  int quantity;
  List<Food> forbiddenFoods;
  List<Medicine> forbiddenMeds;
  bool isNotificationActive;
  String unit;

  Medicine(
      {int id,
      String name,
      List<String> sideEffects,
      String stomach,
      int quantity,
      List<Food> forbiddenFoods,
      List<Medicine> forbiddenMeds,
      bool isNotificationActive,
      String unit}) {
    this.id = id;
    this.name = name;
    this.sideEffects = sideEffects;
    this.stomach = stomach;
    this.quantity = quantity;
    this.forbiddenFoods = forbiddenFoods;
    this.forbiddenMeds = forbiddenMeds;
    this.isNotificationActive = isNotificationActive;
    this.unit = unit;
  }
  void display() {
    print('id: $id\nName: $name\nSide Effect: $sideEffects');
  }
}
