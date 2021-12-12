import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:patient_tracking/Models/medicineVariant.dart';
import 'package:patient_tracking/Providers/medicine_provider.dart';
import 'package:patient_tracking/Providers/patient_provider.dart';
import 'package:patient_tracking/Services/medication_service.dart';
import 'package:patient_tracking/Widgets/topContainer.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../global.dart';
import '../Widgets/ana_menü.dart';
import '../Widgets/accountMenu.dart';

class AnaMenu extends StatefulWidget {
  static const routeName = '/ana-menu';
  @override
  _AnaMenuState createState() => _AnaMenuState();
}

class _AnaMenuState extends State<AnaMenu> {
  List<Widget> widgetOptions = <Widget>[
    AnaMenuGrid(appBar),
    AccountMenu(),
  ];
  void onItemTapped(int index) {
    setState(() {
      Global.initialState = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  static AppBar appBar = AppBar(
    bottomOpacity: 0,
    elevation: 0,
    backgroundColor: kPrimaryColor,
    leading: IconButton(
      onPressed: null,
      icon: Icon(
        Icons.menu,
        color: Colors.black,
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar,
      bottomNavigationBar: bottomNavBar(),
      body: MainScreenTopContainer(widgetOptions: widgetOptions),
      floatingActionButton: Global.initialState == 1
          ? FloatingActionButton(
              backgroundColor: kPrimaryColor,
              onPressed: () => null,
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: FittedBox(fit: BoxFit.fitWidth, child: Text('Kaydet')),
              ),
            )
          : null,
    );
  }

  Container bottomNavBar() {
    return Container(
      padding: EdgeInsets.only(left: 80, right: 80, bottom: 10),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.symmetric(
          horizontal: BorderSide(color: Colors.grey, width: 0.5),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                CircleAvatar(
                  maxRadius: 15,
                  backgroundColor:
                      Global.initialState == 0 ? kPrimaryColor : Colors.grey,
                  child: IconButton(
                    icon: Icon(
                      FontAwesome.home,
                      color: Colors.white,
                      size: 15,
                    ),
                    onPressed: () => onItemTapped(0),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Ana Ekran',
                  style: TextStyle(
                      color: Global.initialState == 0
                          ? kPrimaryColor
                          : Colors.grey,
                      fontWeight: Global.initialState == 0
                          ? FontWeight.bold
                          : FontWeight.normal),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: Column(
              children: [
                CircleAvatar(
                    maxRadius: 15,
                    backgroundColor:
                        Global.initialState == 1 ? kPrimaryColor : Colors.grey,
                    child: IconButton(
                      icon: Icon(
                        FontAwesome.user,
                        size: 15,
                        color: Colors.white,
                      ),
                      onPressed: () => onItemTapped(1),
                    )),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Bilgilerim',
                  style: TextStyle(
                      color: Global.initialState == 1
                          ? kPrimaryColor
                          : Colors.grey,
                      fontWeight: Global.initialState == 1
                          ? FontWeight.bold
                          : FontWeight.normal),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MainScreenTopContainer extends StatelessWidget {
  const MainScreenTopContainer({
    Key key,
    @required this.widgetOptions,
  }) : super(key: key);

  final List<Widget> widgetOptions;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height * 0.1,
          decoration: BoxDecoration(
            border: Border.all(width: 0, color: kPrimaryColor),
            color: kPrimaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),
          child: Row(
            children: [
              Text(
                'Hoşgeldiniz, ${PatientProvider.currentPatient.fullName}',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
              Spacer(),
              Icon(FontAwesome.smile_o)
            ],
          ),
        ),
        widgetOptions.elementAt(Global.initialState),
      ],
    );
  }
}
