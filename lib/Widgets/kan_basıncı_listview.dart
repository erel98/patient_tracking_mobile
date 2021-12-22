import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:provider/provider.dart';

class BloodPressureList extends StatefulWidget {
  @override
  State<BloodPressureList> createState() => _BloodPressureListState();
}

class _BloodPressureListState extends State<BloodPressureList> {
  String printTansiyon(double tansiyon) {
    String retVal = tansiyon.toString();
    retVal = retVal.replaceAll('.0', '');
    return retVal;
  }

  @override
  void initState() {
    super.initState();
    final bpProvider =
        Provider.of<BloodPressureProvider>(context, listen: false);
    bpProvider.getBloodPressures(context);
  }

  @override
  Widget build(BuildContext context) {
    final bpsData = Provider.of<BloodPressureProvider>(context);
    final bps = bpsData.bps;
    bps.forEach((element) {
      print(element.heartBeat);
    });
    Locale myLocale = Localizations.localeOf(context);
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
        itemCount: bps.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Text(
              '${DateFormat.yMMMEd(myLocale.toString()).format(bps[index].time)} ${bps[index].time.hour}:${bps[index].time.minute.toString().padLeft(2, '0')}',
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            trailing: Column(
              children: [
                Text(
                  '${printTansiyon(bps[index].systole)}/${printTansiyon(bps[index].diastole)}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Text(
                  '${bps[index].heartBeat}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
          );
        });
  }
}
