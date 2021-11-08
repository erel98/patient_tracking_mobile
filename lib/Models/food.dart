import 'package:flutter/cupertino.dart';

class Food {
  int id;
  String name;
  Image image;

  Food(int id, String name, Image image) {
    this.id = id;
    this.name = name;
    this.image = image;
  }
}
