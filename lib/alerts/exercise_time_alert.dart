
import 'package:denemee/custom_widgets/exercise_time_select_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

  exerciseTimeAlert(BuildContext context){
    Alert(
        context: context,
        title: "Yeni Antreman",
        style: AlertStyle(
          isOverlayTapDismiss: false
        ),
        content: Column(
          children: <Widget>[
            Icon(FontAwesomeIcons.stopwatch,size: 40.0,color: Colors.red,),
            SizedBox(height: 20.0,),
            ExerciseTimeSelectWidget()
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Başlat",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          )
        ]).show();
}
