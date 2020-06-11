
import 'package:flutter/material.dart';

typedef void LocaleChangeCallback(Locale locale);
class LocaleLangUtil {

  // Support languages list
  final List<String> supportedLanguages = ['en','zh'];

  // Support Locales list
  Iterable<Locale> supportedLocales() => supportedLanguages.map<Locale>((lang) => new Locale(lang, ''));

  // Callback for manual locale changed
  LocaleChangeCallback onLocaleChanged;

  Locale locale;
  String languageCode;

  static final LocaleLangUtil _localeLangUtil = new LocaleLangUtil._internal();

  factory LocaleLangUtil() {
    return _localeLangUtil;
  }

  LocaleLangUtil._internal();

  /// 获取当前系统语言
  String getLanguageCode() {
    if(languageCode == null) {
      return "en";
    }
    return languageCode;
  }
}

LocaleLangUtil localeLangUtil = new LocaleLangUtil();