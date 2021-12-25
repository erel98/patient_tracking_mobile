class DailyMedication {
  int id;
  String medicationName;
  String variantName;
  String imageUrl;
  String quantity;

  DailyMedication(
      {this.id,
      this.medicationName,
      this.variantName,
      this.imageUrl,
      this.quantity});

  void printDailyMed() {
    print(
        'id: $id\nname: $medicationName\nvariantName: $variantName\nurl: $imageUrl\nquantity: $quantity');
  }
}
