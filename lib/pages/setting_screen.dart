
import 'package:denemee/custom_widgets/step_analyse_list_item.dart';
import 'package:denemee/custom_widgets/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text_style.dart';

class SettingPage extends StatefulWidget{

  @override
  _SettingPageState createState() =>_SettingPageState();

}

class _SettingPageState extends State<SettingPage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurpleAccent,title: Text("Ayarlar",style: appbarTitleStyle(),),),
      body: TimerWidget(),
    );
  }

}