import 'package:denemee/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_widget_pair.dart';

class StepAnalyseListItem extends StatefulWidget {

  final String stepSize;
  final String distance;
  final String calories;
  final String date;

  const StepAnalyseListItem({Key key, @required this.stepSize, @required this.distance, @required this.calories, this.date}) : super(key: key);

  @override
  _StepAnalyseListItemState createState() => _StepAnalyseListItemState();
}

class _StepAnalyseListItemState extends State<StepAnalyseListItem> {

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0),bottomRight: Radius.circular(20.0)),
      ),
      color:Colors.transparent,
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(widget.date,style:TextStyle(fontSize: 20.0,color: Colors.white70,fontStyle: FontStyle.normal)),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.walking,iconColor: Colors.blue,sizeBoxHeight: 0.0,data:widget.stepSize,title:null,textStyle: textStyleWidgetPair(16.0,Colors.blue),)),
                        Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.road,iconColor: Colors.purpleAccent,sizeBoxHeight: 0.0,data:widget.distance,title: null,textStyle: textStyleWidgetPair(16.0,Colors.purpleAccent),)),
                        Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.burn,iconColor: Colors.deepOrange,sizeBoxHeight: 0.0,data:widget.calories,title: null,textStyle: textStyleWidgetPair(16.0,Colors.deepOrange),)),
                      ]
                      ,
                    ),
                  ),

                  IconButton(
                    icon: Icon(FontAwesomeIcons.arrowRight),
                    color: Colors.white70,
                    onPressed: (){

                    },
                  )

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
