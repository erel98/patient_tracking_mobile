import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:patient_tracking/Providers/bloodGlucose_provider.dart';
import 'package:patient_tracking/Providers/question_provider.dart';
import 'package:patient_tracking/Screens/organ_transplant_screen.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Providers/bloodPressure_provider.dart';
import 'Screens/ana_menü_screen.dart';
import 'Screens/kullandığım_ilaçlar_screen.dart';
import 'Screens/ilaç_detay_screen.dart';
import 'Screens/hatırlatıcı_screen.dart';
import 'Screens/hava_durumu_screen.dart';
import 'Screens/bugünkü_ilaçlarım_screen.dart';
import 'Screens/login_screen.dart';
import 'Screens/yan_etkiler_screen.dart';
import 'Screens/soru_sor_screen.dart';
import 'Screens/kan_basinci_screen.dart';
import 'Screens/sorularım_screen.dart';
import 'Screens/kan_glikoz_screen.dart';
import 'BildirimAPI.dart';
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
  print('Handling a background message ${message.messageId}');
}

AndroidNotificationChannel channel;
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

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

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
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
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<void> initToken() async {
    String token = await FirebaseMessaging.instance.getToken();
    print('73 $token');
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('fcm_token', token);
  }

  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    print('101: $initialMessage');
    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
      print('101: ${initialMessage.data}');
      print('101: ${initialMessage.mutableContent}');
      print('101: ${initialMessage.from}');
      print('101: ${initialMessage.data}');
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
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: null,
            ),
          ),
        );
      }
    });

    // Also handle any interaction when the app is in the background via a
    // Stream listener
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
      title: 'Hasta Takip Sistemi',
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        //const Locale('en'),
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
      home: LoginScreen(), //LoginScreen(),
      routes: {
        AnaMenu.routeName: (ctx) => AnaMenu(),
        KullandigimIlaclar.routeName: (ctx) => KullandigimIlaclar(),
        IlacDetay.routeName: (ctx) => IlacDetay(),
        Hatirlatici.routeName: (ctx) => Hatirlatici(),
        HavaDurumu.routeName: (ctx) => HavaDurumu(),
        DailyMedsScreen.routeName: (ctx) => DailyMedsScreen(),
        AskQuestionScreen.routeName: (ctx) => AskQuestionScreen(),
        MyQuestionsScreen.routeName: (ctx) => MyQuestionsScreen(),
        SideEffectsScreen.routeName: (ctx) => SideEffectsScreen(),
        BloodPressureScreen.routeName: (ctx) => BloodPressureScreen(),
        BloodGlucoseScreen.routeName: (ctx) => BloodGlucoseScreen(),
        OrganTransplantScreen.routeName: (ctx) => OrganTransplantScreen(),
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
