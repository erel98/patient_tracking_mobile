class Randevu {
  String id;
  DateTime date;
  String hospital;
  String doctorName;
  bool isNotify;

  Randevu(
    String id,
    DateTime date,
    bool isNotify,
    String hospital,
    String doctorName,
  ) {
    this.id = id;
    this.date = date;
    this.isNotify = isNotify;
    this.hospital = hospital;
    this.doctorName = doctorName;
  }
}
