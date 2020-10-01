import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeManager extends ChangeNotifier {
  SharedPreferences sharedPreferences;
  String key = 'darkTheme';
  bool _isDarkTheme = false;

  bool get isDarkTheme => _isDarkTheme;

  ThemeManager() {
    _isDarkTheme = false;
    _loadTheme();
  }

  toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    _saveTheme();
    notifyListeners();
  }

  _initSharedPref() async {
    if (sharedPreferences == null) {
      sharedPreferences = await SharedPreferences.getInstance();
    }
  }

  _saveTheme() async {
    await _initSharedPref();
    sharedPreferences.setBool(key, _isDarkTheme);
  }

  _loadTheme() async {
    await _initSharedPref();
    _isDarkTheme = sharedPreferences.getBool(key) ?? false;
    notifyListeners();
  }
}
