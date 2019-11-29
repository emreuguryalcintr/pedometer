import 'package:denemee/pages/analysis/analysis_daily_screen.dart';
import 'package:denemee/pages/analysis/analysis_exercises_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AnalysisPage extends StatefulWidget {
  const AnalysisPage({Key key}) : super(key: key);

  @override
  _AnalysisPageState createState() => _AnalysisPageState();
}

class _AnalysisPageState extends State<AnalysisPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;

   TabController _tabController;

  @override
  void initState() {

    _tabController = new TabController(vsync: this, length: 2);
    _tabController.animateTo(_tabController.index);
    super.initState();

  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print('tab index is $index');
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: AppBar(
            backgroundColor: Colors.deepPurpleAccent,
            elevation: 0,
            bottom: TabBar(
              tabs: <Tab>[
                new Tab(
                    icon: new Icon(
                      FontAwesomeIcons.list,
                      color: _tabController.index==0?Colors.redAccent:Colors.white,
                    ),
                    text: "Egzersiz"),
                new Tab(
                  icon: new Icon(
                    FontAwesomeIcons.chartLine,
                    color: _tabController.index==1?Colors.redAccent:Colors.white,
                  ),
                  text: "Günlük",
                ),
              ],
              onTap: _onItemTapped,
              controller: _tabController,
              labelColor: Colors.redAccent,
              unselectedLabelColor: Colors.white,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                  color: Colors.white,
             ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: <Widget>[AnalysisListPage(), AnalysisGraphicallyPage()],
        ),
      ),
    );
  }
}
