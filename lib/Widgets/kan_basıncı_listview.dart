import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/bloodPressure_provider.dart';
import 'package:patient_tracking/Widgets/no_data.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

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
    return bps.isNotEmpty
        ? ListView.separated(
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black,
              );
            },
            itemCount: bps.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                leading: IconButton(
                  icon: Icon(
                    FontAwesome5.trash_alt,
                    color: Colors.red,
                  ),
                  onPressed: () async {
                    print('id: ${bps[index].id}');
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Dikkat'),
                            content: Container(
                              child: Text(
                                  'Bu kan basıncı verisini kalıcı olarak silmek istediğinize emin misiniz?'),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () async {
                                  var success = await bpsData
                                      .removeBloodPressure(bps[index].id);
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
            })
        : !bpsData.isLoading
            ? NoDataFound('Kan basıncı veriniz')
            : Container();
  }
}
