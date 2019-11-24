import 'dart:async';
import 'dart:math';

import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/custom_widgets/custom_widget_pair.dart';
import 'package:denemee/custom_widgets/exercise_timer_button.dart';
import 'package:denemee/custom_widgets/timer_widget.dart';
import 'package:denemee/models/step_model.dart';
import 'package:denemee/utils/time_utils.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';

class ExercisePage extends StatefulWidget {
  //final bool isInfinite;
  //final int time;

 // ExercisePage({this.isInfinite, this.time});

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage> with TickerProviderStateMixin {

  String chronometerTime="00:00:00";
  bool isFirstTime=true;
  int initialSteps=0;

  double _convert;
  double _kmx;
  double burnedx;
  double percentStepToTarget = 0.0;
  String _stepCountValue = "0";
  double _stepCounts = 0;
  String _calories = "0.00";
  int targetSteps = 3000;
  String _km = "0.00";

  int totalSavedCount=-1;
  bool sensorIsWorking=true;


  Pedometer pedometer;
  StreamSubscription<int> _streamSubscription;

  final duration=const Duration(seconds: 1);
  var stopwatch=Stopwatch();
  String stopTimeToDisplay="00:00:00";
  bool stopwatchIsRunning=false;




  @override
   initState()  {
    super.initState();

    pedometer=new Pedometer();

    _streamSubscription=pedometer.pedometerStream.listen(onData,onError: _onError,onDone: _onDone);

  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();


  }


  void onData(int steps) async{
    setState(() {
      if(sensorIsWorking){

        totalSavedCount++;
        // stepCountValue=totalSavedCount;
        print('sensor state : $totalSavedCount');
        _stepCountValue = "$totalSavedCount";
        percentStepToTarget = totalSavedCount.toDouble() / targetSteps.toDouble();
      }else{
        print('sensor state is false');
        totalSavedCount=totalSavedCount;
      }
    });

    if(sensorIsWorking){
      var dist = totalSavedCount; //pasamos el entero a una variable llamada dist
      double y = (dist + .0); //lo convertimos a double una forma de varias
      setState(() {

        _stepCounts =
            y; //lo pasamos a un estado para ser capturado ya convertido a double
      });
      var long3 = (_stepCounts);
      long3 = num.parse(y.toStringAsFixed(2));
      var long4 = (long3 / 10000);

      int decimals = 1;
      int fac = pow(10, decimals);
      double d = long4;
      d = (d * fac).round() / fac;
      print("d: $d");

      getDistanceRun(_stepCounts);
      getBurnedRun();

      setState(() {
        _convert = d;
        print(_convert);
      });
    }

  }

  //function to determine the distance run in kilometers using number of steps
  void getDistanceRun(double _stepCounts) {
    var distance = ((_stepCounts * 78) / 100000);
    distance = num.parse(distance.toStringAsFixed(2)); //dos decimales
    var distancekmx = distance * 34;
    distancekmx = num.parse(distancekmx.toStringAsFixed(2));
    //print(distance.runtimeType);
    setState(() {
      _km = "$distance";
      //print(_km);
    });
    setState(() {
      _kmx = num.parse(distancekmx.toStringAsFixed(2));
    });
  }

  //function to determine the calories burned in kilometers using number of steps
  void getBurnedRun() {
    setState(() {
      var calories = _kmx; //dos decimales
      _calories = "$calories";
      //print(_calories);
    });
  }


  void _onDone() => print("Finished pedometer tracking");

  void _onError(error) => print("Flutter Pedometer Error: $error");




  void stopPedometer(){
    _streamSubscription.pause();
  }

  void startTimer(){
    Timer(duration,keepRunning);
  }

  void keepRunning(){
    if(stopwatch.isRunning){
      startTimer();
    }

    setState(() {
      stopTimeToDisplay=timeToDisplay(stopwatch);
    });
  }


  void resetButtonPressed() {
    setState(() {
      stopwatch.reset();
      stopwatch.stop();
      stopTimeToDisplay="00:00:00";
    });
  }

  void pauseAndPlayButtonPressed() {
    setState(() {
      if (stopwatch.isRunning) {
        stopwatch.stop();
      } else {
        stopwatch.start();
        startTimer();
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        backgroundColor: Colors.white,
        appBar:  AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Egzersiz"),
          centerTitle: true,
        ),

        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Column(
                children: <Widget>[


                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[

                          CircularPercentIndicator(
                            radius: MediaQuery
                                .of(context)
                                .size
                                .width / 1.4,
                            progressColor: Colors.cyan,
                            circularStrokeCap: CircularStrokeCap.round,
                            backgroundColor: Colors.transparent,
                            lineWidth: 20.0,
                            animation: false,
                            center: Stack(
                              children: <Widget>[

                                SpinKitFadingCircle(
                                  color: Colors.cyan,
                                  size: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 1.4,
                                  controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
                                ),

                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(FontAwesomeIcons.stopwatch,color: Colors.deepOrange,size: 40.0,),
                                    SizedBox(height: 5.0,),
                                    TimerText(timeToDisplay: stopTimeToDisplay),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Icon(
                                          FontAwesomeIcons.walking,
                                          size: 30.0,
                                          color: Colors.cyan,
                                        ),
                                        Text(
                                          _stepCountValue,
                                          style:
                                          TextStyle(color: Colors.cyan, fontSize: 30.0),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],

                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                ExerciseTimerButton(
                                  icon: Icons.pause,
                                  iconSecondary: Icons.play_arrow,
                                  isWorking:stopwatch.isRunning,
                                  buttonText: stopwatch.isRunning?"Durdur":"Başlat",
                                  colorBackground: Colors.deepPurpleAccent,
                                  colorItems: Colors.white,
                                  onPressed: (){
                                   pauseAndPlayButtonPressed();
                                  },
                                ),
                                ExerciseTimerButton(
                                  icon:Icons.stop,
                                  buttonText: "Bitir",
                                  colorBackground: Colors.deepPurpleAccent,
                                  colorItems: Colors.white,
                                  onPressed: () {
                                    resetButtonPressed();
                                 StepModel model=new StepModel(2222, 1111111111123, 10.3, 5.3, 12112121, "Sınırsız", true);
                                    DocumentReference storeReference=Firestore.instance.collection(FireBaseConstants().dbName_constant).document("1111111111123");
                                    storeReference.setData(model.toMAp());
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                  ),



                  Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        CustomWidgetPair(
                            iconColor: Colors.yellow,
                            icon: FontAwesomeIcons.road,
                            data: "$_km",
                            title: "Km",
                            sizeBoxHeight: 5.0),
                        CustomWidgetPair(
                            iconColor: Colors.orange,
                            icon: FontAwesomeIcons.burn,
                            data: "$_calories",
                            title: "Kcal",
                            sizeBoxHeight: 5.0),
                      ],
                    ),
                  )
                ],
              ),
            ],

          ),
        ));
  }


}
