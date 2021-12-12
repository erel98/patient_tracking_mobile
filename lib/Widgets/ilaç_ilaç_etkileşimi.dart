import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import '../Models/medicine.dart';

class MedToMedInteraction extends StatefulWidget {
  final int medId;
  MedToMedInteraction(this.medId);

  @override
  State<MedToMedInteraction> createState() => _MedToMedInteractionState();
}

class _MedToMedInteractionState extends State<MedToMedInteraction> {
  @override
  Widget build(BuildContext context) {
    final medsData = context.watch<MedicineProvider>();
    final meds = medsData.medVariants;
    return ListView.separated(
      separatorBuilder: (BuildContext ctx, int index) => SizedBox(
        height: 20,
      ),
      itemCount: meds
          .firstWhere((element) => element.id == widget.medId)
          .medication
          .forbiddenMeds
          .length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: kPrimaryColor,
          ),
          child: Center(
            child: ListTile(
              leading: Icon(
                FontAwesome5.hand_point_right,
                size: 30,
                color: Colors.black,
              ),
              title: Text(
                meds
                    .firstWhere((element) => element.id == widget.medId)
                    .medication
                    .forbiddenMeds[index]
                    .name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
