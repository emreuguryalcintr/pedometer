import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseTimerButton extends StatefulWidget {

  final IconData icon;
  final IconData iconSecondary;
  final String buttonText;
  final Color colorBackground;
  final Color colorItems;
  final bool isWorking;
  final GestureTapCallback onPressed;



  ExerciseTimerButton({@required this.onPressed,@required this.icon, this.iconSecondary, @required this.buttonText, @required this.colorBackground, @required this.colorItems,this.isWorking});

  @override
  _ExerciseTimerButtonState createState() => _ExerciseTimerButtonState();
}

class _ExerciseTimerButtonState extends State<ExerciseTimerButton> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      width: MediaQuery.of(context).size.width/3,
      child: RaisedButton(
        child: Row(
          children: <Widget>[
            Icon(widget.isWorking==null?(widget.icon):(widget.isWorking?widget.icon:widget.iconSecondary),color: widget.colorItems,),
            SizedBox(width: 3.0,),
            Text(widget.buttonText,
              style: TextStyle(color:widget.colorItems),)
          ],
        ),
        onPressed:widget.onPressed,
        color: Colors.deepPurpleAccent,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.horizontal(left: Radius.circular(10),right: Radius.circular(10)),
        ),
      ),
    );

  }
}
