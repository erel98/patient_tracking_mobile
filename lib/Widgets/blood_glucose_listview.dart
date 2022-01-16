import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

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
    bgs.sort((a, b) => b.date.compareTo(a.date));
    Locale myLocale = Localizations.localeOf(context);
    return bgs.isNotEmpty
        ? ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    FontAwesome5.trash_alt,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Dikkat'),
                            content: Container(
                              child: Text(
                                  'Bu kan şekeri verisini kalıcı olarak silmek istediğinize emin misiniz?'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  var success = await bgdata
                                      .removeBloodGlucose(bgs[index].id);
                                  if (success) {
                                    Fluttertoast.showToast(
                                        msg:
                                            'Kan basıncı verisi başarıyla silindi');
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: 'Hay aksi! Bir şeyler ters gitti');
                                  }
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  'Evet',
                                  style: TextStyle(color: kPrimaryColor),
                                ),
                              ),
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: Text(
                                  'Hayır',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            ],
                          );
                        });
                  },
                ),
                title: Text(
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
