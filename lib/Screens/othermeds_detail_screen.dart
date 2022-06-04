import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:patient_tracking/Models/otherMedication.dart';
import 'package:provider/provider.dart';

import '../Providers/otherMedication_provider.dart';

class OtherMedsDetails extends StatefulWidget {
  static final routeName = '/othermeds-details';

  @override
  State<OtherMedsDetails> createState() => _OtherMedsDetailsState();
}

class _OtherMedsDetailsState extends State<OtherMedsDetails> {
  int medId;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context).settings.arguments as Map<String, int>;
    medId = routeArgs['medId'] as int;
    final otherMedsData = Provider.of<OtherMedicineProvider>(context);
    final otherMeds = otherMedsData.otherMeds;
    OtherMedication om = otherMeds.where((om2) => om2.id == medId).first;
    return Scaffold(
      body: SingleChildScrollView(
        child: Html(
          data: om.description,
        ),
      ),
    );
  }
}
