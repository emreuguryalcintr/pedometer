import 'package:denemee/styles/text_styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'custom_widget_pair.dart';

class StepAnalyseListItem extends StatefulWidget {

  final String stepSize;
  final String distance;
  final String calories;

  const StepAnalyseListItem({Key key, this.stepSize, this.distance, this.calories}) : super(key: key);

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
      color:Color.fromRGBO	(255,183,0,0.9) ,
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text("22.11.2019",style:TextStyle(fontSize: 20.0,color: Colors.deepPurpleAccent,fontStyle: FontStyle.normal)),
              SizedBox(height: 5.0,),
              Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Row(
                      children: <Widget>[
                        Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.walking,iconColor: Colors.blue,sizeBoxHeight: 0.0,data:"50000",title:null,textStyle: textStyleWidgetPair(16.0,Colors.blue),)),
                        Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.road,iconColor: Colors.purpleAccent,sizeBoxHeight: 0.0,data:"1.12",title: null,textStyle: textStyleWidgetPair(16.0,Colors.purpleAccent),)),
                        Expanded(flex:1,child: CustomWidgetPair(icon: FontAwesomeIcons.burn,iconColor: Colors.deepOrange,sizeBoxHeight: 0.0,data:"1.12",title: null,textStyle: textStyleWidgetPair(16.0,Colors.deepOrange),)),
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
