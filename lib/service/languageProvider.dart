// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  SharedPreferences? _prefs;
  Locale _selectedLocale = Locale('en');

  LanguageProvider() {
    _initPrefs();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
    _selectedLocale = Locale(_prefs!.getString('language') ?? 'en');
    notifyListeners();
  }

  Locale get selectedLocale => _selectedLocale;

  void setLanguage(Locale locale) {
    _selectedLocale = locale;
    _prefs!.setString('language', locale.languageCode);
    notifyListeners();
  }
}
