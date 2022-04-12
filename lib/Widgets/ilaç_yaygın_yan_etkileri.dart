import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class SideEffects extends StatefulWidget {
  final int medId;
  SideEffects(this.medId);

  @override
  State<SideEffects> createState() => _SideEffectsState();
}

class _SideEffectsState extends State<SideEffects> {
  @override
  void initState() {
    super.initState();
    final interactionprovider =
        Provider.of<MedicationInteractionProvider>(context, listen: false);
    interactionprovider.getInteractionsById(widget.medId);
  }

  @override
  Widget build(BuildContext context) {
    final interactionprovider =
        Provider.of<MedicationInteractionProvider>(context);
    var sideEffects = interactionprovider.medInteraction.sideEffects;
    /* if (sideEffects != null) {
      sideEffects.forEach((element) {
        print('side effect: ${element}');
      });
    } */
    return sideEffects == null || sideEffects.isEmpty
        ? NoDataFound('Bilinen yan etki')
        : Html(
            data: sideEffects,
          ); /* ListView.separated(
            separatorBuilder: (BuildContext ctx, int index) => SizedBox(
              height: 20,
            ),
            itemCount: sideEffects.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 50),
                height: 60,
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
                      sideEffects[index],
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
          ); */
  }
}
