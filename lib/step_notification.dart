

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_widgets/custom_widget_pair.dart';

class StepNotification extends StatefulWidget{

  final VoidCallback onReply;

  final String dataSteps;
  final String dataCalorie;
  final String dataDistance;

  const StepNotification({
    Key key,
    @required this.onReply,@required this.dataSteps,@required this.dataCalorie,@required this.dataDistance,
  }) : super(key: key);


  @override
  _StepNotificationState createState() =>_StepNotificationState();

}

class _StepNotificationState extends State<StepNotification> {

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black45,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.walking,iconColor: Colors.cyan,data: widget.dataSteps,sizeBoxHeight: 5.0,)),
              Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.burn,iconColor: Colors.orange,data: widget.dataCalorie,sizeBoxHeight: 5.0,)),
              Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.road,iconColor: Colors.yellow,data: widget.dataDistance,sizeBoxHeight: 5.0,)),

              SizedBox(width: 10.0,),
              IconButton(icon: Icon(FontAwesomeIcons.pause),
                color: Colors.white,
                onPressed: (){
                  if(widget.onReply!=null) widget.onReply();
              },)

            ],
          ),
        )
      ),
    );
  }
}
