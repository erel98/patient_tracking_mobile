import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:patient_tracking/Screens/kan_basinci_screen.dart';
import 'package:patient_tracking/Screens/sorular%C4%B1m_screen.dart';
import 'package:patient_tracking/Screens/notlar%C4%B1m_screen.dart';
import 'package:patient_tracking/constraints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widgets/ana_menü_item.dart';
import 'Screens/kullandığım_ilaçlar_screen.dart';
import 'Screens/hatırlatıcı_screen.dart';
import 'Screens/bugünkü_ilaçlarım_screen.dart';

class Global {
  static List<int> successList = [200, 201, 202, 203, 204, 205, 206];
  static bool isLoading = false;
  static var initialState = 0;
  static int detailsState = 0;
  static List<int> bildirimGunleri = [];
  static Time bildirimSaati;
  static double iconSize = 50;

  static Future<String> getUrl() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getString('URL');
  }

  static var mainMenuItemList = <Widget>[
    AnaMenuItem(
      'İlaçlarım',
      DailyMedsScreen.routeName,
      Icon(
        FontAwesome5Solid.pills,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Kullandığım\nilaçlar',
      KullandigimIlaclar.routeName,
      Icon(
        FontAwesome5Solid.capsules,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Geçmiş',
      '/history',
      Icon(
        FontAwesome5Solid.book_medical,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Hatırlatıcı',
      Hatirlatici.routeName,
      Icon(
        FontAwesome.bell,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Karaciğer\nNakli',
      '/organ-transplant',
      Icon(
        FontAwesome.heart,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Danışmanlık',
      MyQuestionsScreen.routeName,
      Icon(
        FontAwesome.question,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Kan basıncı',
      BloodPressureScreen.routeName,
      ImageIcon(
        AssetImage('assets/icons/blood-pressure.png'),
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Kan glikoz\ndeğeri',
      '/blood-glucose',
      Icon(
        FontAwesome.tint,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Kan ilaç\ndüzeyi',
      '/blood-medicine',
      Icon(
        FontAwesome5Solid.chart_line,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Notlarım',
      NotesScreen.routeName,
      Icon(
        FontAwesome5.sticky_note,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
  ];

  static void warnUser(BuildContext context) {
    AlertDialog alert = AlertDialog(
      title: Text("Dikkat!"),
      content: Text('Lütfen tüm alanları doldurunuz.'),
      actions: [
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Anladım')),
      ],
    );
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
