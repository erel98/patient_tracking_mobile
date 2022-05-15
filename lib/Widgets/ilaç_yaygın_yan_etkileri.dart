import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
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
    return sideEffects == null || sideEffects.isEmpty
        ? NoDataFound('Bilinen yan etki')
        : SingleChildScrollView(
            child: Html(
              data: sideEffects,
            ),
          );
  }
}
