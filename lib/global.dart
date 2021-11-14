import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Widgets/ana_menü_item.dart';
import 'Screens/kullandığım_ilaçlar_screen.dart';
import 'Screens/hatırlatıcı_screen.dart';
import 'Screens/bugünkü_ilaçlarım_screen.dart';

class Global {
  static var initialState = 0;
  static List<int> bildirimGunleri = [];
  static Time bildirimSaati;
  static var mainMenuItemList = <Widget>[
    AnaMenuItem('İlaçlarım', DailyMedsScreen.routeName, null),
    AnaMenuItem('Kullandığım\nilaçlar', KullandigimIlaclar.routeName, null),
    AnaMenuItem('Geçmiş', '', null),
    AnaMenuItem('Hatırlatıcı', Hatirlatici.routeName, null),
    AnaMenuItem('Organ\nTransplant', '', null),
    AnaMenuItem('Danışmanlık', '', null),
    AnaMenuItem('Kan basıncı', '', null),
    AnaMenuItem('Kan glikoz\ndeğeri', '', null),
    AnaMenuItem('Kan ilaç\ndüzeyi', '', null),
    AnaMenuItem('Yan etkiler', '', null),
    AnaMenuItem(
        'Mesajlar',
        '',
        Icon(
          Icons.message,
          color: Colors.black,
          size: 30,
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
