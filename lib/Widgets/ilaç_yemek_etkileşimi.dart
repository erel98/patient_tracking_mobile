import 'package:flutter/material.dart';
import 'package:patient_tracking/Models/food.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';
import '../constraints.dart';

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
        : ListView.separated(
            separatorBuilder: (BuildContext ctx, int index) => SizedBox(
              height: 20,
            ),
            itemCount: foods.length,
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
                    //leading: Image.network(widget.foods[index].imageUrl),
                    title: Text(
                      foods[index].name,
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
