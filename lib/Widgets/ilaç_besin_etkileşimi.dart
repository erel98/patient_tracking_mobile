import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class MedToFoodInteraction extends StatefulWidget {
  final int medId;
  MedToFoodInteraction(this.medId);

  @override
  State<MedToFoodInteraction> createState() => _MedToFoodInteractionState();
}

class _MedToFoodInteractionState extends State<MedToFoodInteraction> {
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
    var foods = interactionprovider.medInteraction.foods;
    return foods == null
        ? NoDataFound('Beraberinde tüketilmemesi gereken yemek')
        : SingleChildScrollView(
            child: Column(
              children: [
                Image.asset(
                  'assets/images/greyfurt.jpeg',
                  scale: 2.5,
                ),
                Html(data: foods),
              ],
            ),
          );
  }
}
