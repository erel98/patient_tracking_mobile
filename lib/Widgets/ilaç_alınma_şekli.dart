import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';

class MedicationUsage extends StatefulWidget {
  final int medId;
  MedicationUsage(this.medId);

  @override
  State<MedicationUsage> createState() => _MedicationUsageState();
}

class _MedicationUsageState extends State<MedicationUsage> {
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
    var usage = interactionprovider.medInteraction.usage;
    return usage == null
        ? NoDataFound("Veri")
        : Html(
            data: usage,
          );
  }
}
