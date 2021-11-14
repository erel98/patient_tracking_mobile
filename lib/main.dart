import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:patient_tracking/constraints.dart';
import 'Screens/ana_menü_screen.dart';
import 'Screens/kullandığım_ilaçlar_screen.dart';
import 'Screens/ilaç_detay_screen.dart';
import 'Screens/hatırlatıcı_screen.dart';
import 'Screens/hava_durumu_screen.dart';
import 'Screens/bugünkü_ilaçlarım_screen.dart';
import 'BildirimAPI.dart';
import 'preferencesController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Providers/medicines.dart';
import 'package:provider/provider.dart';

void main() async {
  /*
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final prefs = await SharedPreferences.getInstance();
  await SharedPreferences.getInstance().then(
    (instance) => PreferecesController.sharedPreferencesInstance = instance);
  */
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    BildirimAPI.init(initScheduled: true);
    listenNotifications();
  }

  void listenNotifications() =>
      BildirimAPI.onNotifications.stream.listen(onClickedNotification);

  void onClickedNotification(String payload) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HavaDurumu(
              //payload: payload
              ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    /*
    const backgroundColor = const Color(0xFF0E7C7B); //background
    const primaryColor = const Color(0xFFD4F4DD); //ana menü item
    const secondaryColor = const Color(0xFF17BEBB); //appbar-navbar
    */
    final ThemeData theme = ThemeData();

    return ChangeNotifierProvider(
      create: (ctx) =>
          Medicines(), //If anything changes, only the widgets that are listening will rebuild
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          visualDensity: VisualDensity.adaptivePlatformDensity,
          primaryColor: kPrimaryColor,
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          appBarTheme: AppBarTheme(color: kPrimaryColor),
          timePickerTheme: TimePickerThemeData(
            backgroundColor: Colors.green,
            helpTextStyle: TextStyle(
              color: Colors.white,
            ),
          ),
          scaffoldBackgroundColor: Colors.white,
        ),
        home: AnaMenu(),
        routes: {
          AnaMenu.routeName: (ctx) => AnaMenu(),
          KullandigimIlaclar.routeName: (ctx) => KullandigimIlaclar(),
          IlacDetay.routeName: (ctx) => IlacDetay(),
          Hatirlatici.routeName: (ctx) => Hatirlatici(),
          HavaDurumu.routeName: (ctx) => HavaDurumu(),
          DailyMedsScreen.routeName: (ctx) => DailyMedsScreen(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
