import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:patient_tracking/Services/patient_service.dart';

import '../constraints.dart';
import '../global.dart';
import '../preferencesController.dart';
import 'myTextField.dart';

class AccountMenu extends StatefulWidget {
  @override
  _AccountMenuState createState() => _AccountMenuState();
}

class _AccountMenuState extends State<AccountMenu> {
  final nameController = TextEditingController();
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final operationDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initControllers();
  }

  void initControllers() {
    nameController.text =
        PreferecesController.sharedPreferencesInstance.getString('name');
    heightController.text = PreferecesController.sharedPreferencesInstance
        .getInt('height')
        .toString();
    weightController.text = PreferecesController.sharedPreferencesInstance
        .getDouble('weight')
        .toString();
    operationDateController.text =
        PreferecesController.sharedPreferencesInstance.getString('op_date');
  }

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
          MyTextField(
            hintText: 'ameliyat tarihiniz',
            controller: operationDateController,
            enabled: false,
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            child: ElevatedButton(
              onPressed: () async {
                if (heightController.text.contains('.') ||
                    heightController.text.contains(',')) {
                  AlertDialog alert = AlertDialog(
                    title: Text("Dikkat!"),
                    content:
                        Text('Boyunuz cm cinsinden bir tam sayı olmalıdır.'),
                    actions: [
                      ElevatedButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: Text('Anladım')),
                    ],
                  );
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return alert;
                    },
                  );
                } else {
                  if (nameController.text.isNotEmpty &&
                      heightController.text.isNotEmpty &&
                      weightController.text.isNotEmpty) {
                    var success = await PatientService.updateMe(
                        name: nameController.text,
                        weight: double.parse(weightController.text),
                        height: int.parse(heightController.text));
                    if (success) {
                      setState(() {
                        Fluttertoast.showToast(
                            msg: 'Bilgileriniz başarıyla güncellendi');
                      });
                    }
                  } else {
                    Global.warnUser(context);
                  }
                }
              },
              child: Text('Kaydet'),
              style: ButtonStyle(
                overlayColor: MaterialStateColor.resolveWith(
                    (states) => Colors.transparent),
                backgroundColor: MaterialStateProperty.all(kPrimaryColor),
              ),
            ),
          )
        ],
      ),
    );
  }
}
