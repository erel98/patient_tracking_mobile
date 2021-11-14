import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:patient_tracking/Providers/medicines.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import 'package:patient_tracking/Screens/ila%C3%A7_detay_screen.dart';

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
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: ListView.separated(
          itemCount: meds.length,
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
              height: 20,
            );
          },
          itemBuilder: (ctx, index) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 10),
                      blurRadius: 50,
                      color: kPrimaryColor.withOpacity(0.23),
                    ),
                  ]),
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
          }),
    );
  }
}
