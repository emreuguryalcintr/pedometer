import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetStartExerciseButton extends StatefulWidget {
  final GestureTapCallback onPressed;
  final String text;

  WidgetStartExerciseButton({@required this.onPressed, @required this.text});

  @override
  _StateWidgetStartExerciseButton createState() =>
      _StateWidgetStartExerciseButton();
}

class _StateWidgetStartExerciseButton extends State<WidgetStartExerciseButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: ButtonTheme(
          height: 40.0,
          minWidth: 120,
          child: RaisedButton(
        child: Text(
          widget.text,
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        color: Colors.blueAccent,
        onPressed: widget.onPressed,
          ),
        ),
      ),
    );
  }
}
