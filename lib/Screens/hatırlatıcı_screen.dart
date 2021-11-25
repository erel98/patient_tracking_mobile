import 'package:flutter/material.dart';

class Hatirlatici extends StatefulWidget {
  static var routeName = '/hatirlatici';
  @override
  _HatirlaticiState createState() => _HatirlaticiState();
}

class _HatirlaticiState extends State<Hatirlatici> {
  @override
  Widget build(BuildContext context) {
    var mq = MediaQuery.of(context).size;
    final havaDurumuController = TextEditingController();
    return Scaffold(
        //resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(),
        body: Column(
          children: [
            Container(
              height: mq.height * 0.4,
              child: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      child: Icon(
                        Icons.cloud,
                        size: 150,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onTap: () =>
                          Navigator.of(context).pushNamed('/hava-durumu')),
                  Text(
                    'Hava durumu bildirimleri',
                    style: Theme.of(context).textTheme.bodyText2,
                  )
                ],
              )),
            ),
            Divider(
              color: Colors.black,
            ),
            Container(
              height: mq.height * 0.4,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      child: Icon(Icons.local_hospital,
                          size: 150,
                          color: Theme.of(context).colorScheme.primary),
                      onTap: () =>
                          Navigator.of(context).pushNamed('/randevu-screen'),
                    ),
                    Text('Randevularım',
                        style: Theme.of(context).textTheme.bodyText2)
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
