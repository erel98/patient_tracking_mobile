import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:patient_tracking/constraints.dart';
import 'Providers/bloodPressures.dart';
import 'Screens/login_screen.dart';
import 'Screens/ana_menü_screen.dart';
import 'Screens/kullandığım_ilaçlar_screen.dart';
import 'Screens/ilaç_detay_screen.dart';
import 'Screens/hatırlatıcı_screen.dart';
import 'Screens/hava_durumu_screen.dart';
import 'Screens/randevularım_screen.dart';
import 'Screens/bugünkü_ilaçlarım_screen.dart';
import 'Screens/yan_etkiler_screen.dart';
import 'Screens/danışmanlık_screen.dart';
import 'Screens/kan_basinci_screen.dart';
import 'BildirimAPI.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './Providers/medicines.dart';
import './Providers/randevus.dart';
import 'package:provider/provider.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

void main() async {
  await dotenv.load();
  /*
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  final prefs = await SharedPreferences.getInstance();
  await SharedPreferences.getInstance().then(
    (instance) => PreferecesController.sharedPreferencesInstance = instance);
  */
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => Medicines(),
      ),
      ChangeNotifierProvider(
        create: (_) => BloodPressures(),
      ),
      ChangeNotifierProvider(
        create: (_) => Randevus(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void initUrl() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('URL', '192.168.1.225:8080');
  }

  @override
  void initState() {
    super.initState();
    initUrl();
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

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
        buttonTheme: ButtonThemeData(splashColor: Colors.transparent),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        primaryColor: kPrimaryColor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        appBarTheme: AppBarTheme(color: kPrimaryColor),
        timePickerTheme: TimePickerThemeData(
          backgroundColor: Colors.white,
          helpTextStyle: TextStyle(
            color: Colors.black,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: LoginScreen(),
      routes: {
        AnaMenu.routeName: (ctx) => AnaMenu(),
        KullandigimIlaclar.routeName: (ctx) => KullandigimIlaclar(),
        IlacDetay.routeName: (ctx) => IlacDetay(),
        Hatirlatici.routeName: (ctx) => Hatirlatici(),
        HavaDurumu.routeName: (ctx) => HavaDurumu(),
        DailyMedsScreen.routeName: (ctx) => DailyMedsScreen(),
        RandevuScreen.routeName: (ctx) => RandevuScreen(),
        QuestionsScreen.routeName: (ctx) => QuestionsScreen(),
        SideEffectsScreen.routeName: (ctx) => SideEffectsScreen(),
        BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),
      },
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
