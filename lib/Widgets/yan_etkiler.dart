import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:provider/provider.dart';
import 'package:patient_tracking/Models/medicine.dart';

class SideEffects extends StatefulWidget {
  final int medId;
  SideEffects(this.medId);

  @override
  State<SideEffects> createState() => _SideEffectsState();
}

class _SideEffectsState extends State<SideEffects> {
  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size;
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    print('id: ${widget.medId}');
    print('Total height: ${mq.height}');
    print('Total width: ${mq.width}');
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      child: ListView.builder(
        itemCount: meds
            .firstWhere((element) => element.id == widget.medId)
            .sideEffects
            .length,
        itemBuilder: (
          BuildContext context,
          int index,
        ) {
          return Container(
            child: ListTile(
              leading: Icon(Icons.check),
              title: Text(
                meds
                    .firstWhere((element) => element.id == widget.medId)
                    .sideEffects[index],
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
