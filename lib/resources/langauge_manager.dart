import 'package:flutter/material.dart';

enum LanguageType { en, ar }

const String arabic = 'ar';
const String english = 'en';
const String localeAssetsPath = 'assets/translations';

const Locale arLocale = Locale('ar', 'SA');
const Locale enLocale = Locale('en', 'US');

extension LanguageTypeExtension on LanguageType {
  String getValue() {
    switch (this) {
      case LanguageType.en:
        return english;
      case LanguageType.ar:
        return arabic;
    }
  }
}
