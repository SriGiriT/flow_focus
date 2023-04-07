import 'package:flutter/material.dart';
import 'package:growbdo/constants.dart';


ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: kPrimaryLightColor,
    scaffoldBackgroundColor: kSecondaryLightColor
    );

ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: kPrimaryDarkColor,
    scaffoldBackgroundColor: kSecondaryDarkColor
    );

class ThemeManager with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;

  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}


// switch theme
/*
Switch(
            value: _themeManager.themeMode == ThemeMode.dark,
            onChanged: (newValue) {
              _themeManager.toggleTheme(newValue);
              setState(() {
                _themeManager.themeMode;
              });
            },
          ),
*/