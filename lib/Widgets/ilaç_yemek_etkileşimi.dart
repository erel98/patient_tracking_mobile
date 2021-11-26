import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/foods.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:provider/provider.dart';
import '../Models/food.dart';

class MedToFoodInteraction extends StatefulWidget {
  final int medId;
  MedToFoodInteraction(this.medId);

  @override
  State<MedToFoodInteraction> createState() => _MedToFoodInteractionState();
}

class _MedToFoodInteractionState extends State<MedToFoodInteraction> {
  @override
  Widget build(BuildContext context) {
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    return ListView.separated(
      separatorBuilder: (BuildContext ctx, int index) => SizedBox(
        height: 20,
      ),
      itemCount: meds
          .firstWhere((element) => element.id == widget.medId)
          .forbiddenFoods
          .length,
      itemBuilder: (
        BuildContext context,
        int index,
      ) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 50),
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xFFE88135),
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
                    .forbiddenFoods[index]
                    .name,
                style: TextStyle(
                  color: Colors.black,
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
