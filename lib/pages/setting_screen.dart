import 'dart:async';
import 'package:denemee/localization/country_list.dart';
import 'package:denemee/localization/locales.dart';
import 'package:denemee/localization/localization_constants.dart';
import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart';
import 'package:denemee/custom_widgets/start_button.dart';
import 'package:denemee/localization/localization_initial_constants.dart';
import 'package:easy_localization/easy_localization.dart' as EasyLocalizationProvider;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../text_style.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {

  int timeForTimer = 0;
  int hour = 0;
  int minute = 0;
  int second = 0;
  String timeToDisplay = "";

  void startTimer() {
    timeForTimer = (hour * 60 * 60) + (minute * 60) + second;
    Timer.periodic(
        Duration(
          seconds: 1,
        ), (Timer t) {
      if (timeForTimer < 1) {
        t.cancel();
      } else {
        timeForTimer -= 1;
      }
      timeToDisplay = timeForTimer.toString();
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

          return MainWidget();
  }
}

class MainWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider.EasyLocalizationProvider(
      data: data,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(
              AppLocalizations.of(context)
                  .translate(LocalizationConstants.settings),
              style: appbarTitleStyle(),
            ),
          ),
          body: Column(
            children: <Widget>[
              WidgetStartExerciseButton(
                onPressed: () {
                  data.changeLocale(Locales.localeTurkish);
                },
                text: AppLocalizations.of(context)
                    .translateGroupChild(parentKey: LocalizationConstants.languages,childKey:LocalizationConstants.turkish),
              ),
              SizedBox(
                height: 30.0,
              ),
              WidgetStartExerciseButton(
                onPressed: () {
                  data.changeLocale(Locales.localeUSEnglish);
                },
                text: AppLocalizations.of(context)
                    .translateGroupChild(parentKey: LocalizationConstants.languages,childKey:LocalizationConstants.english),
              ),
            ],
          )),
    );
  }
}
