import 'dart:io';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:patient_tracking/Providers/bloodMedicine_provider.dart';
import 'package:patient_tracking/Providers/history_provider.dart';
import 'package:patient_tracking/Providers/liverProvider.dart';
import 'package:patient_tracking/Providers/medicationInteraction_provider.dart';
import 'package:patient_tracking/Providers/otherMedication_provider.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Screens/ge%C3%A7mi%C5%9F_screen.dart';
import 'package:patient_tracking/Screens/kan_ila%C3%A7_screen.dart';
import 'package:patient_tracking/Screens/organ_transplant_screen.dart';
import 'package:patient_tracking/Screens/othermeds_detail_screen.dart';
import 'package:patient_tracking/Screens/othermeds_screen.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:patient_tracking/preferencesController.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/bloodPressure_provider.dart';
import 'Providers/dailyMeds_provider.dart';
import 'Screens/ana_menü_screen.dart';
import 'Screens/kullandığım_ilaçlar_screen.dart';
import 'Screens/ilaç_detay_screen.dart';
import 'Screens/hatırlatıcı_screen.dart';
import 'Screens/bugünkü_ilaçlarım_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/notlarım_screen.dart';
import 'Screens/soru_sor_screen.dart';
import 'Screens/kan_basinci_screen.dart';
import 'Screens/sorularım_screen.dart';
import 'Screens/kan_glikoz_screen.dart';
import 'Providers/medicine_provider.dart';
import 'Providers/randevu_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

void main() async {
  HttpOverrides.global = MyHttpOverrides();
  await dotenv.load();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await SharedPreferences.getInstance().then(
      (instance) => PreferecesController.sharedPreferencesInstance = instance);
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  final android = AndroidInitializationSettings('ic_notification');
  final settings = InitializationSettings(
    android: android,
  );

  await flutterLocalNotificationsPlugin.initialize(settings);

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (_) => MedicineProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BloodPressureProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BloodGlucoseProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => RandevuProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => QuestionProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => DailyMedsProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MedicationInteractionProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => BloodMedicineProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => HistoryProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => LiverProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => OtherMedicineProvider(),
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
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  void initToken() {
    _prefs.then((SharedPreferences prefs) => {
          FirebaseMessaging.instance
              .getToken()
              .then((token) => {prefs.setString('fcm_token', token)})
        });
  }

  void fetchIsLoggedIn() {
    _prefs.then((SharedPreferences prefs) => {
          if (prefs.getString('token') == null)
            {prefs.setBool('isloggedin', false)}
          else
            {prefs.setBool('isloggedin', true)}
        });
  }

  Future<void> setupInteractedMessage() async {
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channelDescription: channel.description,
            ),
          ),
        );
      }
    });
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) {
    if (message.data['type'] == 'chat') {
      //open a page
    }
  }

  @override
  void initState() {
    super.initState();
    FirebaseAnalytics anal = FirebaseAnalytics.instance;

    initToken();
    setupInteractedMessage();
    fetchIsLoggedIn();
  }

  /* void onClickedNotification(String payload) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => HavaDurumu(
              //payload: payload
              ),
        ),
      ); */
  bool isLoggedIn() {
    return PreferecesController.sharedPreferencesInstance
            .getBool('isloggedin') ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'Hasta Takip Sistemi',
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('tr'),
      ],
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
      builder: EasyLoading.init(
        builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: child),
      ),
      home: isLoggedIn() ? AnaMenu() : LoginScreen(), //LoginScreen(),
      routes: {
        AnaMenu.routeName: (ctx) => AnaMenu(),
        KullandigimIlaclar.routeName: (ctx) => KullandigimIlaclar(),
        IlacDetay.routeName: (ctx) => IlacDetay(),
        Hatirlatici.routeName: (ctx) => Hatirlatici(),
        DailyMedsScreen.routeName: (ctx) => DailyMedsScreen(),
        AskQuestionScreen.routeName: (ctx) => AskQuestionScreen(),
        MyQuestionsScreen.routeName: (ctx) => MyQuestionsScreen(),
        NotesScreen.routeName: (ctx) => NotesScreen(),
        BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),
        BloodGlucoseScreen.routeName: (ctx) => BloodGlucoseScreen(),
        OrganTransplantScreen.routeName: (ctx) => OrganTransplantScreen(),
        BloodMedicineScreen.routeName: (ctx) => BloodMedicineScreen(),
        HistoryScreen.routeName: (ctx) => HistoryScreen(),
        OtherMeds.routeName: (ctx) => OtherMeds(),
        OtherMedsDetails.routeName: (ctx) => OtherMedsDetails()
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

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
