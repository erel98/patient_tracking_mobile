import 'food.dart';

class Medicine {
  int id;
  String name;
  String sideEffect;
  String stomach;
  int quantity;
  List<Food> forbiddenFoods;
  List<Medicine> forbiddenMeds;
  bool isNotificationActive;

  Medicine([
    int id,
    String name,
    String sideEffect,
    String stomach,
    int quantity,
    List<Food> forbiddenFoods,
    List<Medicine> forbiddenMeds,
    bool isNotificationActive,
  ]) {
    this.id = id;
    this.name = name;
    this.sideEffect = sideEffect;
    this.stomach = stomach;
    this.quantity = quantity;
    this.forbiddenFoods = forbiddenFoods;
    this.forbiddenMeds = forbiddenMeds;
    this.isNotificationActive = isNotificationActive;
  }
  void display() {
    print('id: $id\nName: $name\nSide Effect: $sideEffect');
  }
}
