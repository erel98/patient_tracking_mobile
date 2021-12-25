import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';

class BloodGlucoseList extends StatefulWidget {
  @override
  _BloodGlucoseListState createState() => _BloodGlucoseListState();
}

class _BloodGlucoseListState extends State<BloodGlucoseList> {
  @override
  void initState() {
    super.initState();
    var bgprovider = Provider.of<BloodGlucoseProvider>(context, listen: false);
    bgprovider.getBloodGlucoses();
  }

  @override
  Widget build(BuildContext context) {
    var bgdata = Provider.of<BloodGlucoseProvider>(context);
    var bgs = bgdata.bgs;
    Locale myLocale = Localizations.localeOf(context);
    return bgs.isNotEmpty
        ? ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: Text(
                  '${DateFormat.yMMMEd(myLocale.toString()).format(bgs[index].date)} ${bgs[index].date.hour}:${bgs[index].date.minute.toString().padLeft(2, '0')}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                trailing: Text(
                  '${bgs[index].value}',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );
            },
            itemCount: bgs.length)
        : !bgdata.isLoading
            ? NoDataFound('Kan şekeri değeriniz')
            : Container();
  }
}
