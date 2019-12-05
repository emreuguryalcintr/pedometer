import 'dart:convert';
import 'dart:ui';

import 'package:denemee/localization/locales.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  // Helper method to keep the code in the widgets concise
  // Localizations are accessed using an InheritedWidget "of" syntax
  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
  _AppLocalizationsDelegate();


  Map<String, String> _localizedStrings;
  Map<String,dynamic> _localizedInnerJson;

  Future<bool> load() async {
    // Load the language JSON file from the "lang" folder
    String jsonString =
    await rootBundle.loadString('resources/lang/${locale.languageCode}-${locale.countryCode}.json');
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    print("map2: ${jsonMap.runtimeType.toString()}");

    _localizedStrings = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });

    _localizedInnerJson=jsonMap.map((key,value){
      return MapEntry(key,value);
    });

    return true;
  }

  // This method will be called from every widget which needs a localized text
  String translate(String key) {
    return _localizedStrings[key];
  }

  String translateGroupChild({@required String parentKey,@required String childKey}){

    Map<dynamic, dynamic> localized= _localizedInnerJson[parentKey].map((key,value){
      return MapEntry(key, value.toString());
    });

    return localized[childKey].toString();
  }
}

// LocalizationsDelegate is a factory for a set of localized resources
// In this case, the localized strings will be gotten in an AppLocalizations object
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  // This delegate instance will never change (it doesn't even have fields!)
  // It can provide a constant constructor.
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // Include all of your supported language codes here
    return Locales.supportedLanguages.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    AppLocalizations localizations = new AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}