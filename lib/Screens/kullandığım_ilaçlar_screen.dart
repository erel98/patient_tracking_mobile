import 'package:flutter/material.dart';
import '../dummy_data.dart';
import 'ilaç_detay_screen.dart';

class KullandigimIlaclar extends StatefulWidget {
  static const routeName = '/kullandigim-ilaclar';
  @override
  _KullandigimIlaclarState createState() => _KullandigimIlaclarState();
}

class _KullandigimIlaclarState extends State<KullandigimIlaclar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
          itemCount: DUMMY_MEDS.length,
          itemBuilder: (ctx, index) {
            return Container(
              width: MediaQuery.of(context).size.width * 0.6,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: Card(
                color: Colors.green,
                //elevation: 40,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: Icon(
                    Icons.medication,
                    color: Colors.black,
                  ),
                  title: Text(
                    DUMMY_MEDS[index].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.arrow_right,
                      color: Colors.black,
                      size: 35,
                    ),
                    onPressed: () => Navigator.pushNamed(
                      context,
                      IlacDetay.routeName,
                      arguments: {'medId': DUMMY_MEDS[index].id},
                    ),
                  ),
                ),
              ),
            );
          }),
    );
  }
}
