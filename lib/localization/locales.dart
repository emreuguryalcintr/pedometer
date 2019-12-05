import 'package:flutter/cupertino.dart';

import 'country_list.dart';

class Locales {
  static var supportedLanguages = [
    CountryList.tr_language,
    CountryList.us_language
  ];

  static Locale localeTurkish = Locale(CountryList.tr_language, CountryList.tr_country);
  static Locale localeUSEnglish = Locale(CountryList.us_language, CountryList.us_country);
}
