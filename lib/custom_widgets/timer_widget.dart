import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';


class TimerText extends StatefulWidget {
  final String timeToDisplay;
  TimerText({this.timeToDisplay});

  _TimerTextState createState() => new _TimerTextState();
}

class _TimerTextState extends State<TimerText> {


  @override
  Widget build(BuildContext context) {

    return new Text(widget.timeToDisplay,style: TextStyle(fontSize: 22.0),);
  }
}

class TimerWidget extends StatefulWidget {
  @override
  _TimerWidgetState createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {
   int hour=0;
   int minute=0;
   int second=0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.min,
        children: <Widget>[
          Expanded(
            flex: 6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("HH"),
                    ),
                    NumberPicker.integer(
                        initialValue:hour,
                        minValue: 0,
                        maxValue: 24,
                        listViewWidth: 50.0,
                        onChanged: (val){
                         setState(() {
                           hour=val;
                         });
                        }
                        )

                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("MM"),
                    ),
                    NumberPicker.integer(
                        initialValue:minute,
                        minValue: 0,
                        maxValue: 24,
                        listViewWidth: 50.0,
                        onChanged: (val){
                          setState(() {
                            minute=val;
                          });
                        }
                    )

                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(bottom: 10.0),
                      child: Text("SS"),
                    ),
                    NumberPicker.integer(
                        initialValue:second,
                        minValue: 0,
                        maxValue: 24,
                        listViewWidth: 50.0,
                        onChanged: (val){
                          setState(() {
                            second=val;
                          });
                        }
                    )

                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

