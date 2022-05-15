import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class MedEffect extends StatefulWidget {
  final int medId;
  MedEffect(this.medId);

  @override
  State<MedEffect> createState() => _MedEffectState();
}

class _MedEffectState extends State<MedEffect> {
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
    var meds = interactionprovider.medInteraction.effects; //String
    return meds == null
        ? NoDataFound('Beraberinde alınmaması gereken ilaç')
        : SingleChildScrollView(
            child: Html(data: meds),
          );
  }
}
