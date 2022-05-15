import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:provider/provider.dart';

import 'no_data.dart';

class MedToMedInteraction extends StatefulWidget {
  final int medId;
  MedToMedInteraction(this.medId);

  @override
  State<MedToMedInteraction> createState() => _MedToMedInteractionState();
}

class _MedToMedInteractionState extends State<MedToMedInteraction> {
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
    var medtomed = interactionprovider.medInteraction.medToMedInteraction;
    return medtomed == null || medtomed.isEmpty
        ? NoDataFound('Bilinen yan etki')
        : Html(
            data: medtomed,
          );
  }
}
