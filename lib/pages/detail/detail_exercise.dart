import 'package:denemee/custom_widgets/custom_widget_pair.dart';
import 'package:denemee/models/daily_model.dart';
import 'package:denemee/models/exercise_model.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailExercisePage extends StatefulWidget {
   final ExerciseModel exerciseModel;
   final DailyModel dailyModel;

  DetailExercisePage({this.exerciseModel, this.dailyModel});

  @override
  _DetailExercisePageState createState() => _DetailExercisePageState();
}

class _DetailExercisePageState extends State<DetailExercisePage> {
  bool isModelEmpty;
  dynamic model;
  ExerciseModel exerciseModel;
  DailyModel dailyModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    isModelEmpty = (widget.exerciseModel != null || widget.dailyModel != null);

    exerciseModel=widget.exerciseModel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Egzersiz"),
      ),
      body: Container(
        color: Colors.white10,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 15.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        CustomWidgetPair(
                          icon: FontAwesomeIcons.stopwatch,
                          data: convertDateAndTimeFromTimestamps(exerciseModel.startTime,format: format_dateAndTime),
                          iconColor: Colors.black,
                          sizeBoxHeight: 5.0,
                          iconSize: 30.0,
                        ),
                        Icon(FontAwesomeIcons.arrowRight),
                        CustomWidgetPair(
                          icon: FontAwesomeIcons.stopwatch,
                          data: convertDateAndTimeFromTimestamps(exerciseModel.endTime,format: format_dateAndTime),
                          iconColor: Colors.black,
                          sizeBoxHeight: 5.0,
                          iconSize: 30.0,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0,),
                    Container(
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 5.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Tamamlanma Durumu' ),
                          Icon(exerciseModel.isCompleted?FontAwesomeIcons.check:FontAwesomeIcons.times,color: exerciseModel.isCompleted?Colors.lightGreenAccent:Colors.red,size: 30.0,)
                        ],
                      ),
                    ),
                    SizedBox(height: 10.0,),

                    Container(
                      color: Colors.white,
                      height: 40.0,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('Egzersiz Türü'),
                          Text('${exerciseModel.exerciseTypeStatus()}')
                        ],
                      ),
                    ),

                  ],

                ),
              ),



              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.walking,
                      color: Colors.cyan,
                      size: 50.0,
                    ),
                    Text(
                      "${exerciseModel.stepCount}",
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 22.0,
                          fontStyle: FontStyle.normal,
                          letterSpacing: 2),
                    )
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: CustomWidgetPair(
                        iconColor: Colors.yellow,
                        icon: FontAwesomeIcons.road,
                        data: '${exerciseModel.distance}',
                        title: "Km",
                        sizeBoxHeight: 5.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomWidgetPair(
                        iconColor: Colors.orange,
                        icon: FontAwesomeIcons.burn,
                        data: '${exerciseModel.calories}',
                        title: "Kcal",
                        sizeBoxHeight: 5.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: CustomWidgetPair(
                        iconColor: Colors.redAccent,
                        icon: FontAwesomeIcons.stopwatch,
                        data: '${convertWalkingTime(exerciseModel.walkingTime)}',
                        title: "Yürüyüş Süresi",
                        sizeBoxHeight: 5.0),
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
