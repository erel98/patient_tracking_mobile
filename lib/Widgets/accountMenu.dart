import 'package:flutter/material.dart';
import 'package:patient_tracking/constraints.dart';

import 'myTextField.dart';

class AccountMenu extends StatefulWidget {
  @override
  _AccountMenuState createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  final nameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(15),
      child: Column(
        children: [
          MyTextField(
            hintText: 'tam adınız',
            inputType: TextInputType.name,
            controller: nameController,
          ),
          MyTextField(
              hintText: 'boyunuz',
              inputType: TextInputType.number,
              controller: heightController),
          MyTextField(
              hintText: 'kilonuz',
              inputType: TextInputType.number,
              controller: weightController),
        ],
      ),
    );
  }
}
