import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:patient_tracking/Models/otherMedication.dart';
import 'package:patient_tracking/constraints.dart';
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
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: Column(
          children: [
            TopContainer(),
            SingleChildScrollView(
              child: Html(
                data: om.description,
              ),
            ),
          ],
        ));
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        border: Border.all(width: 0, color: kPrimaryColor),
        color: kPrimaryColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
    );
  }
}
