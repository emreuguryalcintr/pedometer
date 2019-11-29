import 'package:denemee/pages/analysis/analysis_main_screen.dart';
import 'package:denemee/pages/step_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'exercise_screen.dart';
import 'setting_screen.dart';
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
      debugShowCheckedModeBanner: false,
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
    StepPage(  key: PageStorageKey('StepPage'),),
    ExercisePage(  key: PageStorageKey('ExercisePage'),),
    AnalysisPage(  key: PageStorageKey('AnalysisPage'),),
    SettingPage(  key: PageStorageKey('SettingPage'),),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: _widgetOptions.elementAt(_selectedIndex),
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.deepPurple,
        unselectedItemColor: Colors.white30,
        selectedItemColor: Colors.cyan,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.wb_sunny),
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
