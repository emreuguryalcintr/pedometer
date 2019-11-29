
import 'package:flutter/material.dart';

Widget buildGroupSeparator(dynamic groupByValue) {
  return Container(
    height: 50.0,
    color: Colors.blueGrey[700],
    padding: EdgeInsets.symmetric(horizontal: 16.0),
    alignment: Alignment.centerLeft,
    child: Text(
      '$groupByValue',
      style: const TextStyle(color: Colors.white),
    ),
  );
}