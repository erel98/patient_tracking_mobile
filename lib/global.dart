import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:patient_tracking/Screens/soru_sor_screen.dart';
import 'package:patient_tracking/Screens/kan_basinci_screen.dart';
import 'package:patient_tracking/Screens/sorular%C4%B1m_screen.dart';
import 'package:patient_tracking/Screens/yan_etkiler_screen.dart';
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
      '',
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
      'Organ\nTransplant',
      '',
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
      '',
      Icon(
        FontAwesome5Solid.chart_line,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
      'Yan etkiler',
      SideEffectsScreen.routeName,
      Icon(
        FontAwesome5.sticky_note,
        color: kMenuIconColor,
        size: iconSize,
      ),
    ),
    AnaMenuItem(
        'Mesajlar',
        '',
        Icon(
          Icons.message,
          color: kMenuIconColor,
          size: iconSize,
        )),
  ];
  static void setBildirimGunleri() async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isPazartesi', false);
    prefs.setBool('isSali', false);
    prefs.setBool('isCarsamba', false);
    prefs.setBool('isPersembe', false);
    prefs.setBool('isCuma', false);
    prefs.setBool('isCumartesi', false);
    prefs.setBool('isPazar', false);
    bildirimGunleri.forEach((element) {
      if (element == 1)
        prefs.setBool('isPazartesi', true);
      else if (element == 2)
        prefs.setBool('isSali', true);
      else if (element == 3)
        prefs.setBool('isCarsamba', true);
      else if (element == 4)
        prefs.setBool('isPersembe', true);
      else if (element == 5)
        prefs.setBool('isCuma', true);
      else if (element == 6)
        prefs.setBool('isCumartesi', true);
      else if (element == 7) prefs.setBool('isPazar', true);
    });
  }

  static void setBildirimSaati(DateTime time) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setInt('bildirim-saat', time.hour);
    prefs.setInt('bildirim-dakika', time.minute);
  }
}
