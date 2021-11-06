class Patient {
  int id;
  String fullName;
  String gender;
  int age;
  double weight;
  double height;
  double bpTreshold;
  double bsTreshold;
  String email;
  String mobileNumber;
  String address;

  Patient(
      [int id,
      String fullName,
      String gender,
      int age,
      double weight,
      double height,
      double bpTreshold,
      double bsTreshold,
      String email,
      String mobileNumber,
      String address]) {
    this.id = id;
    this.fullName = fullName;
    this.gender = gender;
    this.age = age;
    this.weight = weight;
    this.height = height;
    this.bpTreshold = bpTreshold;
    this.bsTreshold = bsTreshold;
    this.mobileNumber = mobileNumber;
    this.address = address;
  }
}
