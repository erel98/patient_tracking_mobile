import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Models/randevu.dart';
import 'package:patient_tracking/Providers/randevu_provider.dart';
import 'package:provider/provider.dart';

class RandevuWidget extends StatefulWidget {
  @override
  State<RandevuWidget> createState() => _RandevuWidgetState();
}

class _RandevuWidgetState extends State<RandevuWidget> {
  @override
  void initState() {
    super.initState();
    final randevuprovider =
        Provider.of<RandevuProvider>(context, listen: false);
    randevuprovider.getRandevusList(context);
  }

  String parseMinute(int minute) {
    return minute < 10 ? '0$minute' : '$minute';
  }

  @override
  Widget build(BuildContext context) {
    Locale myLocale = Localizations.localeOf(context);
    final randevuData = Provider.of<RandevuProvider>(context);
    final randevus = randevuData.randevuList;
    return ListView.builder(
      itemCount: randevus.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
            leading: Icon(Icons.calendar_today),
            title: Text(
              randevus[index].reminderText,
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
            subtitle: Text(
              '${DateFormat.yMMMEd(myLocale.toString()).format(randevus[index].date)} ' +
                  ' ${randevus[index].date.hour}:${parseMinute(randevus[index].date.minute)}',
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            trailing: IconButton(
              icon: Icon(
                FontAwesome5.trash_alt,
                color: Colors.red,
              ),
              onPressed: () async {
                var success =
                    await randevuData.removeRandevu(randevus[index].id);
                if (success) {
                  Fluttertoast.showToast(msg: 'Randevu başarıyla silindi');
                } else {
                  Fluttertoast.showToast(
                      msg: 'Hay aksi! Bir şeyler ters gitti');
                }
              },
            ));
      },
    );
  }
}
