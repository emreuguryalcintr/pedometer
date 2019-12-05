import 'dart:async';
import 'dart:math';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/constants/general_constants.dart';
import 'package:denemee/localization/localization_constants.dart';
import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart';
import 'package:denemee/custom_libraries/liquid_circular_progress_indicator/liquid_circular_lcpi.dart';
import 'package:denemee/custom_widgets/custom_widget_pair.dart';
import 'package:denemee/custom_widgets/exercise_timer_button.dart';
import 'package:denemee/custom_widgets/start_button.dart';
import 'package:denemee/custom_widgets/timer_widget.dart';
import 'package:denemee/dialog/exercise_time_alert.dart';
import 'package:denemee/localization/localization_initial_constants.dart';
import 'package:denemee/models/daily_model.dart';
import 'package:denemee/models/exercise_model.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pedometer/pedometer.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ExercisePage extends StatefulWidget {
  const ExercisePage({Key key}) : super(key: key);

  @override
  _ExercisePageState createState() => _ExercisePageState();
}

class _ExercisePageState extends State<ExercisePage>
    with TickerProviderStateMixin {

  int initialSteps = 0;

  double _convert;
  double _kmx;
  double burnedx;
  double percentStepToTarget = 0.0;
  String _stepCountValue = "0";
  double _stepCounts = 0;
  String _calories = "0.00";
  Timestamp _startTime;
  Timestamp _endTime;

  int targetSteps = 3000;
  String _km = "0.00";

  int totalSavedCount = 0;
  bool sensorIsWorking = true;

  int timeForTimer = 0;
  Timer timer;

  String selectedWidgetName = "_widgetButton";
  static const String widgetButton = "_widgetButton";
  static const String widgetExercise = "_widgetExercise";
  static const String widgetDialog = "_widgetDialog";
  String chronometerTime = "00:00:00";
  bool isFirstTime = true;

  Pedometer pedometer;
  StreamSubscription<int> _streamSubscription;

  final duration = const Duration(seconds: -1);
  Duration timerDuration = Duration(seconds: 0, minutes: 5);
  var stopwatch = Stopwatch();
  String stopTimeToDisplay = "00:00:00";
  bool stopwatchIsRunning = false;

  Firestore _firestore;
  bool isStopwatchBegunFirstly = false;
  String _exerciseType;

  AnimationController _animationController;

  @override
  initState() {
    _firestore = Firestore.instance;

    pedometer = new Pedometer();

    if (sensorIsWorking) {
      _streamSubscription = pedometer.pedometerStream
          .listen(onData, onError: _onError, onDone: _onDone);
    }

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animationController.repeat();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();

    if (timer != null) {
      timer.cancel();
    }
    super.dispose();
  }

  void onData(int steps) async {
    totalSavedCount++;
    // stepCountValue=totalSavedCount;
    print('exercise sensor state : $totalSavedCount');
    _stepCountValue = "$totalSavedCount";
    percentStepToTarget = totalSavedCount.toDouble() / targetSteps.toDouble();

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
      print('convert $_convert');
    });
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

  void playWorking() {
    setState(() {
      //_isPlayWorking=_isPlayWorking?false:true;

      if(_exerciseType==GeneralConstants.EXERCISE_TYPE_INFINITE){
        if (!stopwatch.isRunning) {
          print("play working stopwatch is running");
          // cancelListening();
          _animationController.repeat();
          sensorIsWorking = false;
          //pauseListening();
        } else {
          _animationController.reset();
          sensorIsWorking = true;

          if (_streamSubscription.isPaused) {
            resumeListening();
          } else {
            // startListening();
          }
        }
      }else{
        startTimer();
      }

    });
  }

  void pauseAndPlayButtonPressed() {
    setState(() {
      if(_exerciseType==GeneralConstants.EXERCISE_TYPE_INFINITE){
        if (stopwatch.isRunning) {
          stopwatch.stop();
        } else {
          if (!isStopwatchBegunFirstly) {
            _startTime = Timestamp.fromMillisecondsSinceEpoch(
                new DateTime.now().millisecondsSinceEpoch);
            isStopwatchBegunFirstly = true;
          }
          stopwatch.start();
          startStopwatch();
        }
      }else{
        if(timer.isActive){
        }
      }

    });
  }


  void pauseListening() {
    _streamSubscription.pause();
  }

  void resumeListening() {
    _streamSubscription.resume();
  }

  void stopPedometer() {
    _streamSubscription.pause();
  }

  void startStopwatch() {
    Timer(duration, keepRunningStopwatch);
  }

  void startTimer() {
    timer = Timer.periodic(duration, (Timer timer) {
      setState(() {
        if (timeForTimer < 1) {
          timer.cancel();
        } else {
          timeForTimer -= 1;
        }
        stopTimeToDisplay = convertWalkingTime(timeForTimer);
      });
    });
  }

  void keepRunningStopwatch() {
    if (stopwatch.isRunning) {
      startStopwatch();
    }

    setState(() {
      stopTimeToDisplay = timeToDisplayStopwatch(stopwatch);
    });
  }

  void resetButtonPressed() {
    setState(() {
      stopwatch.reset();
      stopwatch.stop();
      stopTimeToDisplay = "00:00:00";
    });
  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return   Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.deepPurpleAccent,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: Text(AppLocalizations.of(context).translate(LocalizationConstants.exercise)),
          centerTitle: true,
        ),
        body: _selectedWidget(),
      );
  }

  Widget _widgetExercise() {
    return SafeArea(
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
                      Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.width / 1.8,
                        child: LiquidCircularProgressIndicatorCustomLCPI(
                          animationController: _animationController,
                          value: 0.15,
                          // Defaults to 0.5.
                          valueColor: AlwaysStoppedAnimation(
                            Colors.deepPurple,
                          ),
                          // Defaults to the current Theme's accentColor.
                          backgroundColor: Colors.white,
                          // Defaults to the current Theme's backgroundColor.
                          borderColor: Colors.cyan,
                          borderWidth: 5.0,
                          direction: Axis.vertical,
                          center: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(
                                FontAwesomeIcons.stopwatch,
                                color: Colors.deepOrange,
                                size: 40.0,
                              ),
                              SizedBox(
                                height: 5.0,
                              ),
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
                                    '$totalSavedCount',
                                    style: TextStyle(
                                        color: Colors.cyan, fontSize: 30.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
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
                              isWorking: stopwatch.isRunning,
                              buttonText:
                                  stopwatch.isRunning ? AppLocalizations.of(context).translate(LocalizationConstants.pause) : AppLocalizations.of(context).translate(LocalizationConstants.start),
                              colorBackground: Colors.deepPurpleAccent,
                              colorItems: Colors.white,
                              onPressed: () {
                                pauseAndPlayButtonPressed();
                                playWorking();
                              },
                            ),
                            ExerciseTimerButton(
                              icon: Icons.stop,
                              buttonText: AppLocalizations.of(context).translate(LocalizationConstants.stop),
                              colorBackground: Colors.deepPurpleAccent,
                              colorItems: Colors.white,
                              onPressed: () {
                                _endTime = Timestamp.fromMillisecondsSinceEpoch(
                                    new DateTime.now().millisecondsSinceEpoch);
                                if (totalSavedCount > 0) {
                                  ExerciseModel exerciseModel =
                                      new ExerciseModel(
                                          stepCount: totalSavedCount,
                                          calories: double.parse(_calories),
                                          distance: double.parse(_km),
                                          walkingTime: getWalkingTimeInSeconds(
                                              stopwatch),
                                          exerciseType: "infinite",
                                          isCompleted: true,
                                          memberKey: "BDUZU",
                                          endTime: _endTime,
                                          startTime: _startTime);

                                  DocumentReference storeReferenceExercise =
                                      _firestore
                                          .collection(
                                              FireBaseConstants.dbName_exercise)
                                          .document();
                                  storeReferenceExercise
                                      .setData(exerciseModel.toMAp())
                                      .whenComplete(() => {});

                                  DailyModel dailyModel = DailyModel(
                                      stepCount: totalSavedCount,
                                      calories: double.parse(_calories),
                                      distance: double.parse(_km),
                                      walkingTime:
                                          getWalkingTimeInSeconds(stopwatch),
                                      memberKey: "BDUZU",
                                      endTime: _endTime,
                                      startTime: _startTime);

                                  DocumentReference storeReferenceDaily =
                                      _firestore
                                          .collection(
                                              FireBaseConstants.dbName_daily)
                                          .document();
                                  storeReferenceDaily
                                      .setData(dailyModel.toMAp())
                                      .whenComplete(() => {});

                                  setState(() {
                                    totalSavedCount = 0;
                                    _calories = "0.00";
                                    _km = "0.00";
                                  });
                                } else {
                                  print("geçersiz değer:  kayıt yapılamadı");
                                }

                                resetButtonPressed();
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
    );
  }

  Widget _selectedWidget() {
    Widget selectedWidget;
    switch (selectedWidgetName) {
      case widgetButton:
        selectedWidget = WidgetStartExerciseButton(
          text: AppLocalizations.of(context).translate(LocalizationConstants.start_exercise),
          onPressed: () {
            setState(() {
              selectedWidgetName = widgetDialog;
            });
          },
        );
        break;
      case widgetDialog:
        selectedWidget = ExerciseTimeAlert(
          shortMin: AppLocalizations.of(context).translateGroupChild(parentKey: LocalizationConstants.time_constants,childKey:LocalizationConstants.minute_short),
          shortHour: AppLocalizations.of(context).translateGroupChild(parentKey: LocalizationConstants.time_constants,childKey:LocalizationConstants.hour_short),
          startText:AppLocalizations.of(context).translate(LocalizationConstants.start),
          cancelText:AppLocalizations.of(context).translate(LocalizationConstants.cancel),
          finiteExerciseText:AppLocalizations.of(context).translate(LocalizationConstants.finite_exercise),
          infiniteExerciseText:AppLocalizations.of(context).translate(LocalizationConstants.infinite_exercise),
          durationData: durationFromAlert,
          duration: timerDuration,
          onPressedStart: () {
            setState(() {
              selectedWidgetName = widgetExercise;
              pauseAndPlayButtonPressed();
              //startTimer();
              print('widget duration: ${timeForTimer.toString()}');
            });
          },
          onPressedCancel: () {
            setState(() {
              selectedWidgetName = widgetButton;
            });
          },
          exerciseType: exerciseTypeFromWidget
        );
        break;
      case widgetExercise:
        selectedWidget = _widgetExercise();
        break;
    }

    return selectedWidget;
  }

  void durationFromAlert(dynamic childValue) {
    setState(() {
      timeForTimer = childValue;
    });
  }

  void exerciseTypeFromWidget(String exerciseType){
    setState(() {
      _exerciseType=exerciseType;
    });
  }
}
