import 'dart:async';

import 'package:denemee/pages/analysis/analysis_main_screen.dart';
import 'package:denemee/pages/step_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:pedometer/pedometer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'dart:math';
import 'setting_screen.dart';
import 'exercise_screen.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget{
  final String title;

  MyHomePage({Key key, this.title}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();

}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static List<Widget> _widgetOptions = <Widget>[
    StepPage(),
    ExercisePage(),
    AnalysisPage(),
    SettingPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.cyan,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.running),
            title: Text('Günlük'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.running),
            title: Text('Egzersiz'),
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.chartPie),
            title: Text('Analiz'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Ayarlar'),
          ),


        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

}
