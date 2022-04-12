import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_icons/flutter_icons.dart';
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
        : Html(data: meds);
    /* ListView.separated(
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
          ); */
  }
}
