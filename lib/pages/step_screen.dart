import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/localization/localization_constants.dart';
import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart';
import 'package:denemee/custom_libraries/liquid_circular_progress_indicator/liquid_circular_lcpi.dart';
import 'package:denemee/custom_widgets/custom_widget_pair.dart';
import 'package:denemee/localization/localization_initial_constants.dart';
import 'package:denemee/models/daily_model.dart';
import 'package:denemee/utils/shared_pref_utils.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedometer/pedometer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';


class StepPage extends StatefulWidget {
  const StepPage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<StepPage>  with SingleTickerProviderStateMixin{
  String buttonName;

  bool _isPlayWorking = true;

  double _stepCounts = 0;
  double _convert;
  double _kmx;
  double burnedX;
  double percentStepToTarget = 0.0;
  String _stepCountValue = "0";
  String _calories = "0.00";
  int targetSteps = 3000;
  String _distance = "0.00";

  StreamSubscription<int> _streamSubscription;
  Pedometer _pedometer;
  int totalSavedCount = 0;
  bool sensorIsWorking = true;
  Firestore _fireStore;
  DailyModel dailyModel;
  Timestamp startTime;
  Timestamp endTime;
  int walkingTime;
  int totalStepFromFireStore = 0;

  Stopwatch stopwatch = Stopwatch();

  final duration = const Duration(seconds: 1);
  var walkingTimeDuration = "00:00:00";

  AnimationController _animationController;


  @override
  void initState() {
    super.initState();

    _fireStore = Firestore.instance;
    startTime = Timestamp.fromMillisecondsSinceEpoch(
        new DateTime.now().millisecondsSinceEpoch);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animationController.repeat();
    // if the stream had no results, this will be null
    // if the stream has one or more results, this will be the last result

    initPlatformState();

    loadDailySteps();

    startTimer();

    getDeviceId();
   // startServiceForPlatformAndroid();

  }
  Future getDeviceId() async{
    String device_id=  await SharedPrefUtils.getPrefValue("device_id");
    print("device id is : $device_id");
  }

  @override
  void dispose() {

    //ya da stop
    stopwatch.reset();

    if (totalSavedCount > 1) {
      endTime = Timestamp.fromMillisecondsSinceEpoch(
          new DateTime.now().millisecondsSinceEpoch);
      walkingTime = (endTime.millisecondsSinceEpoch ~/ 1000) -
          (startTime.millisecondsSinceEpoch ~/ 1000);

      dailyModel = DailyModel(
          calories: double.parse(_calories),
          distance: double.parse(_distance),
          endTime: endTime,
          memberKey: "BDUZU",
          startTime: startTime,
          stepCount: totalSavedCount,
          walkingTime: walkingTime);
      _fireStore
          .collection(FireBaseConstants.dbName_daily)
          .document()
          .setData(dailyModel.toMAp(), merge: true)
          .whenComplete(() => {});
    }

    super.dispose();
    print('step screen dispose method');
  }

  void loadDailySteps() {
    setState(() {
      Firestore.instance
          .collection(FireBaseConstants.dbName_daily)
          .orderBy(FireBaseConstants.startTime_constant)
          .where(FireBaseConstants.startTime_constant,
              isGreaterThan: getDateStamps(getNowDate()),
              isLessThan: getDateStamps(getDateDifference(day: 1)))
          .snapshots()
          .listen((data) => {
                data.documents.forEach((d) => {
                      totalStepFromFireStore +=
                          d[FireBaseConstants.stepCount_constant]
                    })
              });
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

  void startTimer() {
    stopwatch.start();
    Timer(duration, keepRunning);
  }

  void keepRunning() {
    if (stopwatch.isRunning) {
      startTimer();
    }

    setState(() {
      walkingTimeDuration = timeToDisplayStopwatch(stopwatch);
    });
  }

  void playWorking() {
    setState(() {
      //_isPlayWorking=_isPlayWorking?false:true;

      if (_isPlayWorking) {
        _isPlayWorking = false;
        _animationController.stop();
        sensorIsWorking = false;
        // cancelListening();
        pauseListening();


      } else {

       // startServiceForPlatformAndroid();
        _animationController.repeat();
        _isPlayWorking = true;
        sensorIsWorking = true;
        if (_streamSubscription.isPaused) {
          resumeListening();
        } else {
          // startListening();
        }
      }
    });
  }

  Future<void> initPlatformState() async {
    startListening();
  }

  void startListening() {
    _pedometer = new Pedometer();
    _streamSubscription = _pedometer.pedometerStream.listen(_onData,
        onError: _onError, onDone: _onDone, cancelOnError: true);
  }

  void _onData(int stepCountValue) async {
    print('on data state');
    print('$stepCountValue');

    setState(() {
      if (sensorIsWorking) {
        totalSavedCount++;
        // stepCountValue=totalSavedCount;
        print('sensor state : $totalSavedCount');
        _stepCountValue = "$totalSavedCount";
        percentStepToTarget =
            totalSavedCount.toDouble() / targetSteps.toDouble();
      }
    });

    if (sensorIsWorking) {
      var dist =
          totalSavedCount; //pasamos el entero a una variable llamada dist
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
      _distance = "$distance";
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

  void cancelListening() {
    _streamSubscription.cancel();
  }

  void pauseListening() {
    _streamSubscription.pause();
  }

  void resumeListening() {
    _streamSubscription.resume();
  }

  void resetListening() {
    setState(() {
      int stepCountValue = 0;
      stepCountValue = 0;
      _stepCountValue = "$stepCountValue";
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:localizationDelegates(),
      supportedLocales:supportedLanguages(),
      localeResolutionCallback: localeResolutionCallback(),
      home: new Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton(
                    backgroundColor: Colors.transparent,
                    child: Icon(
                      FontAwesomeIcons.running,
                      color: Colors.cyan,
                    ),
                    onPressed: () {},
                  ),
                ),
                Column(
                  children: <Widget>[
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      "${AppLocalizations.of(context).translate(LocalizationConstants.for_today)} $totalStepFromFireStore",
                      style: TextStyle(
                          color: Colors.deepPurpleAccent, fontSize: 22.0),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          FloatingActionButton(
                            splashColor: Colors.deepOrange,
                            backgroundColor: Colors.white,
                            child: Icon(
                              _isPlayWorking ? Icons.pause : Icons.play_arrow,
                              color: Colors.cyan,
                              size: 35.0,
                            ),
                            onPressed: () {
                              playWorking();
                              pauseAndPlayButtonPressed();
                            },
                          ),
                          FloatingActionButton(
                            splashColor: Colors.deepOrange,
                            backgroundColor: Colors.cyan,
                            child: Icon(
                              Icons.add,
                              size: 30.0,
                            ),
                            onPressed: () {
                              //exerciseTimeAlert(context);
                              Navigator.of(context).pushNamed("/exercise_screen");
                            },
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Center(
                          child: Container(
                        width: MediaQuery.of(context).size.width / 1.8,
                        height: MediaQuery.of(context).size.width / 1.8,
                        child: LiquidCircularProgressIndicatorCustomLCPI(
                          animationController: _animationController,
                          value: percentStepToTarget < 0.11 ? 0.1 : percentStepToTarget,
                          // Defaults to 0.5.
                          valueColor: AlwaysStoppedAnimation(
                            Colors.purpleAccent,
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
                              Column(
                                children: <Widget>[
                                  Text(
                                    AppLocalizations.of(context).translate(LocalizationConstants.target),
                                    style: TextStyle(fontSize: 24.0),
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "$targetSteps",
                                    style: TextStyle(fontSize: 22.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
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
                                    '$_stepCountValue',
                                    style: TextStyle(
                                        color: Colors.cyan, fontSize: 30.0),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            flex: 1,
                            child: CustomWidgetPair(
                                iconColor: Colors.yellow,
                                icon: FontAwesomeIcons.road,
                                data: "$_distance",
                                title: "Km",
                                sizeBoxHeight: 5.0),
                          ),
                          Expanded(
                            flex: 1,
                            child: CustomWidgetPair(
                                iconColor: Colors.orange,
                                icon: FontAwesomeIcons.burn,
                                data: "$_calories",
                                title: "Kcal",
                                sizeBoxHeight: 5.0),
                          ),
                          Expanded(
                            flex: 1,
                            child: CustomWidgetPair(
                                iconColor: Colors.redAccent,
                                icon: FontAwesomeIcons.stopwatch,
                                data: '$walkingTimeDuration',
                                title: AppLocalizations.of(context).translate(LocalizationConstants.walking_time),
                                sizeBoxHeight: 5.0),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          )),
    );
  }


  void startServiceForPlatformAndroid() async{
    if(Platform.isAndroid){
      var methodChannel=MethodChannel("com.example.denemee.messages");
      String data=await methodChannel.invokeMethod("startService");
      debugPrint(data);

    }

  }



}
