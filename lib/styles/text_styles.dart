import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

TextStyle textStyleWidgetPair(double fontSize,Color textColor){
  return TextStyle(
    fontSize: fontSize,
    color: textColor
  );
}

TextStyle textStyleTitle(){
  return TextStyle(
    fontSize: 22.0,
    color: Colors.white30,
    decoration: TextDecoration.none
    );
}