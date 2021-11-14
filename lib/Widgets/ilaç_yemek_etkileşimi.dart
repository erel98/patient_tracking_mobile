import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/foods.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:provider/provider.dart';
import '../Models/food.dart';

class MedToFoodInteraction extends StatelessWidget {
  final int medId;
  MedToFoodInteraction(this.medId);

  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
          itemCount: meds
              .firstWhere((element) => element.id == medId)
              .forbiddenFoods
              .length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: ListTile(
                leading: Icon(Icons.check),
                title: Text(
                  meds
                      .firstWhere((element) => element.id == medId)
                      .forbiddenFoods[index]
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
