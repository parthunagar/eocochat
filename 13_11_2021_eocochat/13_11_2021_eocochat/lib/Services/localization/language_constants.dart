//*************   © Copyrighted by Thinkcreative_Technologies. An Exclusive item of Envato market. Make sure you have purchased a Regular License OR Extended license for the Source Code from Envato to use this product. See the License Defination attached with source code. *********************

import 'package:fiberchat/Services/localization/demo_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: todo
//TODO:---- All localizations settings----
const String LAGUAGE_CODE = 'languageCode';

//languages code
const String ENGLISH = 'en';
const String VIETNAMESE = 'vi';
const String ARABIC = 'ar';
const String HINDI = 'hi';
const String GERMAN = 'de';
const String SPANISH = 'es';
const String FRENCH = 'fr';
const String INDONESIAN = 'id';
const String JAPANESE = 'ja';
const String KOREAN = 'ko';
const String TURKISH = 'tr';
const String CHINESE = 'zh';
const String DUTCH = 'nl';
const String BANGLA = 'bn';
//----
const String PORTUGUESE = 'pt';
const String URDU = 'ur';
const String SWAHILI = 'sw';
const String RUSSIAN = 'ru';

List languagelist = [
  ENGLISH,
  BANGLA,
  ARABIC,
  HINDI,
  GERMAN,
  SPANISH,
  FRENCH,
  INDONESIAN,
  JAPANESE,
  KOREAN,
  TURKISH,
  CHINESE,
  VIETNAMESE,
  DUTCH,
  //-----
  URDU,
  PORTUGUESE,
  SWAHILI,
  RUSSIAN,
];
List<Locale> supportedlocale = [
  Locale(ENGLISH, "US"),
  Locale(ARABIC, "SA"),
  Locale(HINDI, "IN"),
  Locale(BANGLA, "BD"),
  Locale(GERMAN, "DE"),
  Locale(SPANISH, "ES"),
  Locale(FRENCH, "FR"),
  Locale(INDONESIAN, "ID"),
  Locale(JAPANESE, "JP"),
  Locale(KOREAN, "KR"),
  Locale(TURKISH, "TR"),
  Locale(CHINESE, "CN"),
  Locale(VIETNAMESE, 'VN'),
  Locale(DUTCH, 'NZ'),
  //----
  Locale(URDU, 'PK'),
  Locale(PORTUGUESE, 'PT'),
  Locale(SWAHILI, 'KE'),
  Locale(RUSSIAN, 'RU')
];

Future<Locale> setLocale(String languageCode) async {
  print("setLocale => languageCode 1 : $languageCode");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.setString(LAGUAGE_CODE, languageCode);
  print("setLocale => languageCode 2 : $languageCode");
  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  print("getLocale => LAGUAGE_CODE : $LAGUAGE_CODE");
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  //TODO: change default language in localization : 15/03/2022
  String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "en";
  // String languageCode = _prefs.getString(LAGUAGE_CODE) ?? "fr";
  print("getLocale => languageCode : ${languageCode.toString()}");

  return _locale(languageCode);
}

Locale _locale(String languageCode) {
  switch (languageCode) {
    case ENGLISH:
      return Locale(ENGLISH, 'US');
    case BANGLA:
      return Locale(BANGLA, 'BD');
    case VIETNAMESE:
      return Locale(VIETNAMESE, "VN");
    case ARABIC:
      return Locale(ARABIC, "SA");
    case HINDI:
      return Locale(HINDI, "IN");
    case GERMAN:
      return Locale(GERMAN, "DE");
    case SPANISH:
      return Locale(SPANISH, "ES");
    case FRENCH:
      return Locale(FRENCH, "FR");
    case INDONESIAN:
      return Locale(INDONESIAN, "ID");
    case JAPANESE:
      return Locale(JAPANESE, "JP");
    case KOREAN:
      return Locale(KOREAN, "KR");
    case TURKISH:
      return Locale(TURKISH, "TR");
    case DUTCH:
      return Locale(DUTCH, "NZ");
    case CHINESE:
      // return Locale.fromSubtags(languageCode: CHINESE);
      return Locale(CHINESE, "CN");
    //---
    case URDU:
      return Locale(URDU, 'PK');
    case PORTUGUESE:
      return Locale(PORTUGUESE, 'PT');
    case SWAHILI:
      return Locale(SWAHILI, 'KE');
    case RUSSIAN:
      return Locale(RUSSIAN, 'RU');

    default:
      return Locale(ENGLISH, 'US');
  }
}

String getTranslated(BuildContext context, String key) {
  return DemoLocalization.of(context)!.translate(key) ?? '';
}
