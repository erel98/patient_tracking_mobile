class Medicine {
  int id;
  String name;
  String sideEffect;
  Map<int, String> medToMedInteraction;
  Map<int, String> medToFoodInteraction;

  Medicine(
      [int id,
      String name,
      String sideEffect,
      Map<int, String> medToMedInteraction,
      Map<int, String> medToFoodInteraction]) {
    this.id = id;
    this.name = name;
    this.sideEffect = sideEffect;
    this.medToMedInteraction = medToMedInteraction;
    this.medToFoodInteraction = medToFoodInteraction;
  }
  void display() {
    print('id: $id\nName: $name\nSide Effect: $sideEffect');
  }
}
