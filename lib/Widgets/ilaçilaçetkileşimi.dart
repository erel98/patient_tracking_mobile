import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:provider/provider.dart';
import '../dummy_data.dart';
import '../Models/medicine.dart';

class MedToMedInteraction extends StatelessWidget {
  String getMedicineById(int id) {
    String retVal = '';
    DUMMY_MEDS.forEach((element) {
      if (element.id == id) {
        retVal = element.name;
      }
    });
    return retVal;
  }

  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    return Container();
  }
}
