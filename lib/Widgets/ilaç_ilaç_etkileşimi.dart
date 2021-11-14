import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:provider/provider.dart';
import '../Models/medicine.dart';

class MedToMedInteraction extends StatelessWidget {
  final int medId;
  MedToMedInteraction(this.medId);
  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
          itemCount: meds
              .firstWhere((element) => element.id == medId)
              .forbiddenMeds
              .length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  meds
                      .firstWhere((element) => element.id == medId)
                      .forbiddenMeds[index]
                      .name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
