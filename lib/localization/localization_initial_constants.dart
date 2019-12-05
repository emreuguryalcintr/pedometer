
import 'dart:ui';

import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart';
import 'package:denemee/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';


Iterable<LocalizationsDelegate<dynamic>> localizationDelegates(){
  return
   [ AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,

  ];
}

Iterable<Locale> supportedLanguages(){
  return [Locales.localeTurkish, Locales.localeUSEnglish];
}

LocaleResolutionCallback localeResolutionCallback(){
  return (locale, supportedLocales) {
// Check if the current device locale is supported
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
// If the locale of the device is not supported, use the first one
// from the list (English, in this case).
    return supportedLocales.first;
  };
}

