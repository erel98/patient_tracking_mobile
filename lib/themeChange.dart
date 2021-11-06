import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeChange extends ChangeNotifier {
  static const PRIMARY = Color.fromRGBO(28, 28, 46, 1);
  static const ACCENT = Colors.white;

  bool isDark = true;
  final SharedPreferences _prefs;

  Color primaryColor = PRIMARY;
  Color accentColor = ACCENT;

  void changeColor() {
    isDark = !isDark;

    primaryColor = isDark ? PRIMARY : ACCENT;
    accentColor = isDark ? ACCENT : PRIMARY;
    notifyListeners();

    _prefs.setBool('isDark', isDark);
  }

  ThemeChange(this._prefs) {
    isDark = _prefs.getBool('isDark') ?? true;
    primaryColor = isDark ? PRIMARY : ACCENT;
    accentColor = isDark ? ACCENT : PRIMARY;
  }

  static ThemeChange of(BuildContext context) {
    final provider =
        context.dependOnInheritedWidgetOfExactType<ThemeChangeProvider>();
    return provider.controller;
  }
}

class ThemeChangeProvider extends InheritedWidget {
  const ThemeChangeProvider({Key key, this.controller, Widget child})
      : super(key: key, child: child);

  final ThemeChange controller;

  @override
  bool updateShouldNotify(ThemeChangeProvider old) =>
      controller != old.controller;
}
