import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:patient_tracking/Providers/liverProvider.dart';
import 'package:provider/provider.dart';

import '../constraints.dart';

class LiverInfoWidget extends StatefulWidget {
  final int infoIndex;
  LiverInfoWidget(this.infoIndex);

  @override
  State<LiverInfoWidget> createState() => _LiverInfoWidgetState();
}

class _LiverInfoWidgetState extends State<LiverInfoWidget> {
  @override
  void initState() {
    super.initState();
    final infoProvider = Provider.of<LiverProvider>(context, listen: false);
    infoProvider.getLiverInfo();
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final infoData = Provider.of<LiverProvider>(context);
    final info = infoData.info;

    var text = widget.infoIndex == 1 ? info.i1 : info.i2;

    var mq = MediaQuery.of(context).size;
    return Container(
      height: mq.height * 0.7,
      width: mq.width * 0.9,
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: kPrimaryColor.withOpacity(0.23),
            blurRadius: 50,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: SingleChildScrollView(child: Html(data: text)),
      ),
    );
  }
}
