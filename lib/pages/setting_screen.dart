import 'dart:async';
import 'package:denemee/custom_widgets/timer_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../text_style.dart';

class SettingPage extends StatefulWidget {
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
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text(
          "Ayarlar",
          style: appbarTitleStyle(),
        ),
      ),
      body: Column(
        children: <Widget>[
          TimerWidget(),
          SizedBox(
            height: 20.0,
          ),
          Text(timeToDisplay),
          SizedBox(
            height: 30.0,
          ),
          RaisedButton(onPressed: startTimer)
        ],
      ),
    );
  }
}
