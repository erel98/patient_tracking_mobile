import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';

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
    var meds = interactionprovider.medInteraction.medications;
    return meds == null
        ? NoDataFound('Beraberinde alınmaması gereken ilaç')
        : ListView.separated(
            separatorBuilder: (BuildContext ctx, int index) => SizedBox(
              height: 20,
            ),
            itemCount: meds.length,
            itemBuilder: (
              BuildContext context,
              int index,
            ) {
              return ListTile(
                leading: Icon(
                  FontAwesome5.hand_point_right,
                  size: 30,
                  color: Colors.black,
                ),
                title: meds[index].imageUrl != null &&
                        meds[index].imageUrl.isNotEmpty
                    ? Container(
                        margin: EdgeInsets.all(0),
                        child: Image.network(
                          dotenv.env['IMAGE_URL'] + meds[index].imageUrl,
                        ),
                      )
                    : Text(
                        meds[index].name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
              );
            },
          );
  }
}
