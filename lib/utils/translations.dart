

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show  rootBundle;

import 'locale_lang_util.dart';

/// Class for Translate
///
/// For example:
///
/// import 'package:workout/translations.dart';
///
/// ```dart
/// For TextField content
/// Translations.of(context).text("home_page_title");
/// ```
///
/// ```dart
/// For speak string
/// Note: Tts will speak english if currentLanguage[# Tts's parameter] can't support
///
/// Translations.of(context).speakText("home_page_title");
/// ```
///
/// "home_page_title" is the key for text value
///
class Translations {


  Locale locale;
  static Map<dynamic, dynamic> _localizedValues;
  static Map<dynamic, dynamic> _localizedValuesEn; // English map

  Translations(Locale locale) {
    this.locale = locale;
//    _localizedValues = null;
  }

  static Translations _translations;

  static Translations of(BuildContext context) {
    if(_translations == null){
      _translations = Localizations.of<Translations>(context, Translations);
    }
    return _translations;
  }

  String text(String key) {

    try {
      String value = _localizedValues[key];
      if(value == null || value.isEmpty) {
        return englishText(key);
      } else {
        return value;
      }
    } catch (e) {
      print(e);
      return englishText(key);
    }
  }

  String englishText(String key) {
    return _localizedValuesEn[key] ?? key;
  }

  static Future<Translations> load(Locale locale) async {
    if(_translations != null){
      return _translations;
    }
    Translations translations = new Translations(locale);
    // 语言选择
    switch(locale.languageCode){
      case 'zh':
        String jsonContent = await rootBundle.loadString("locale/lang/zh_CH.json");
        _localizedValues = json.decode(jsonContent);
        break;
      default:
        String jsonContent = await rootBundle.loadString("locale/lang/en_US.json");
        _localizedValues = json.decode(jsonContent);
        break;
    }

    String enJsonContent = await rootBundle.loadString("locale/lang/en_US.json");
    _localizedValuesEn = json.decode(enJsonContent);

    return translations;
  }

  get currentLanguage => locale.languageCode;


}

class TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const TranslationsDelegate();

  // Support languages
  @override
  bool isSupported(Locale locale) {
    localeLangUtil.languageCode = locale.languageCode;
    return localeLangUtil.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) => Translations.load(locale);

  @override
  bool shouldReload(TranslationsDelegate old) => true;
}

// Delegate strong init a Translations instance when language was changed
class SpecificLocalizationDelegate extends LocalizationsDelegate<Translations> {
  final Locale overriddenLocale;

  const SpecificLocalizationDelegate(this.overriddenLocale);

  @override
  bool isSupported(Locale locale) => overriddenLocale != null;

  @override
  Future<Translations> load(Locale locale) => Translations.load(overriddenLocale);

  @override
  bool shouldReload(LocalizationsDelegate<Translations> old) => true;
}