class DailyMedication {
  int id;
  String medicationName;
  String variantName;
  String imageUrl;
  String quantity;
  DateTime tookAt;

  DailyMedication(
      {this.id,
      this.medicationName,
      this.variantName,
      this.imageUrl,
      this.quantity,
      this.tookAt});
}
