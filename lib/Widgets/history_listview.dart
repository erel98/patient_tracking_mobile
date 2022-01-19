import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:patient_tracking/Providers/history_provider.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  void initState() {
    super.initState();
    final historyProvider =
        Provider.of<HistoryProvider>(context, listen: false);
    historyProvider.getHistories();
  }

  String getSubtitle(DateTime time) {
    if (time == null) {
      return '';
    } else {
      final DateFormat formatter = DateFormat(dateFormat2);
      final String formatted = formatter.format(time);
      return ', $formatted';
    }
  }

  @override
  Widget build(BuildContext context) {
    final historyProvider = Provider.of<HistoryProvider>(context);
    var histories = historyProvider.histories;
    return ListView.builder(
        itemCount: histories.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(
                dotenv.env['IMAGE_URL'] + histories[index].imageUrl),
            title: Text(histories[index].name),
            subtitle: Text(
                '${histories[index].quantity}${getSubtitle(histories[index].takeTime)}'),
            trailing: histories[index].isTaken
                ? Icon(
                    FontAwesome5.smile_beam,
                    size: 40,
                    color: kPrimaryColor,
                  )
                : Icon(
                    FontAwesome5.frown,
                    size: 40,
                    color: Colors.red,
                  ),
          );
        });
  }
}
