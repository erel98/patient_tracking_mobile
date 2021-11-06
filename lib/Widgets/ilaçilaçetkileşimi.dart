import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../dummy_data.dart';
import '../Models/medicine.dart';

class MedToMedInteraction extends StatelessWidget {
  Map<int, String> interactions;
  MedToMedInteraction(this.interactions);

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
    return interactions.length > 0
        ? ListView.builder(
            itemCount: interactions.length,
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 40,
                child: Row(
                  children: [
                    Text(
                      '${getMedicineById(interactions.keys.elementAt(index))}: ',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      interactions.values.elementAt(index),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              );
            })
        : Container();
  }
}
