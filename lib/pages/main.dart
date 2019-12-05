import 'package:denemee/localization/localization_constants.dart';
import 'package:denemee/constants/shared_prefs_constants.dart';
import 'package:denemee/localization/localization_initial_constants.dart';
import 'package:denemee/pages/analysis/analysis_main_screen.dart';
import 'package:denemee/pages/step_screen.dart';
import 'package:denemee/utils/shared_pref_utils.dart';
import 'package:easy_localization/easy_localization_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'setting_screen.dart';
import 'exercise_screen.dart';
import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart';


void main()=> runApp(EasyLocalization(child: MyApp()));


class MyApp extends StatelessWidget {


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: MaterialApp(
              title: 'NetoMeter',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home:MyHomePage(),
              debugShowCheckedModeBanner: false,
              localizationsDelegates:localizationDelegates(),
              supportedLocales:supportedLanguages(),
              locale: data.savedLocale,
            ),
    );
        }
  }

class MyHomePage extends StatefulWidget {
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    StepPage(key: PageStorageKey('StepPage'),),
    ExercisePage(key: PageStorageKey('ExercisePage'),),
    AnalysisPage(key: PageStorageKey('AnalysisPage'),),
    SettingPage(key: PageStorageKey('SettingPage'),),

  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    SharedPrefUtils.setPefValue(
        SharedPrefsConstant.dailyStepPrefName, "device_id");

    super.initState();
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    var data = EasyLocalizationProvider.of(context).data;
    return EasyLocalizationProvider(
      data: data,
      child: Scaffold(
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.deepPurple,
          unselectedItemColor: Colors.white30,
          selectedItemColor: Colors.cyan,
          items: <BottomNavigationBarItem>[

            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              title: Text(AppLocalizations.of(context).translate(LocalizationConstants.daily)),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.running),
              title: Text(AppLocalizations.of(context).translate(
                  LocalizationConstants.exercise)),
            ),
            BottomNavigationBarItem(
              icon: Icon(FontAwesomeIcons.chartPie),
              title: Text(AppLocalizations.of(context).translate(
                  LocalizationConstants.analyse)),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context).translate(
                  LocalizationConstants.settings)),
            ),


          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }

}
