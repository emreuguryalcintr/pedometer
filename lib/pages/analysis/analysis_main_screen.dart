import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalysisPage extends StatefulWidget {
  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage> {

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final tab = new TabBar(tabs: <Tab>[
    new Tab(icon: new Icon(FontAwesomeIcons.list,color: Colors.white30,),text: "Liste",),
    new Tab(icon: new Icon(FontAwesomeIcons.chartLine,color: Colors.white30,),text: "Grafik",),
  ],
  labelColor: Colors.purpleAccent,
  indicatorColor: Colors.black,);


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top:4.0),
              child: tab,
            )
          ),
        ),
      ),
    );
  }


}
