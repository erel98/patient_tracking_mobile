import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:patient_tracking/Screens/ila%C3%A7_detay_screen.dart';
import 'package:provider/provider.dart';

class UsedMeds extends StatefulWidget {
  @override
  State<UsedMeds> createState() => _UsedMedsState();
}

class _UsedMedsState extends State<UsedMeds> {
  @override
  Widget build(BuildContext context) {
    //Main.dart'ta oluşturduğumuz provider'a listener ekliyoruz.
    final medsData = Provider.of<Medicines>(context);
    final meds = medsData.meds;
    return ListView.separated(
        itemCount: meds.length,
        separatorBuilder: (BuildContext context, int index) {
          return Divider(
            color: Colors.black,
          );
        },
        itemBuilder: (ctx, index) {
          return Container(
            decoration: BoxDecoration(),
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                IlacDetay.routeName,
                arguments: {'medId': meds[index].id},
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: meds[index].isNotificationActive
                      ? Colors.green
                      : Colors.grey,
                  child: IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {
                      setState(() {
                        meds[index].isNotificationActive =
                            !meds[index].isNotificationActive;
                      });
                    },
                  ),
                ),
                title: Text(
                  meds[index].name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
                subtitle: Text(
                  '${meds[index].stomach}, ${meds[index].quantity} adet',
                  style: TextStyle(color: Colors.grey, fontSize: 17),
                ),
                trailing: Image.asset(
                  'assets/icons/Clock-icon.png',
                  width: 75,
                  height: 70,
                ),
              ),
            ),
          );
        });
  }
}
