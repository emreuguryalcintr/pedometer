import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/models/daily_model.dart';
import 'package:flutter/cupertino.dart';

class ExerciseModel {
  Timestamp startTime;
  Timestamp endTime;
  String memberKey;
  int stepCount;
  double calories;
  double distance;
  int walkingTime;
  String exerciseType;
  bool isCompleted;

  DailyModel dailyModel;


  ExerciseModel({@required this.startTime, @required this.endTime, @required this.memberKey, @required this.stepCount,
    @required this.calories, @required this.distance, @required this.walkingTime,@required this.exerciseType,@required this.isCompleted});

  ExerciseModel.empty();
  ExerciseModel.withDailyModel({@required this.exerciseType,@required this.isCompleted,@required this.dailyModel});



  Map toMapWithDailyModel(){
    var map=new Map<String,dynamic>();
    map[FireBaseConstants.startTime_constant]=dailyModel.startTime;
    map[FireBaseConstants.endTime_constant]=dailyModel.endTime;
    map[FireBaseConstants.memberKey_constant]=dailyModel.memberKey;
    map[FireBaseConstants.stepCount_constant]=dailyModel.stepCount;
    map[FireBaseConstants.calories_constant]=dailyModel.calories;
    map[FireBaseConstants.distance_constant]=dailyModel.distance;
    map[FireBaseConstants.walkingTime_constant]=dailyModel.walkingTime;
    map[FireBaseConstants.exerciseType_constant]=exerciseType;
    map[FireBaseConstants.isCompleted_constant]=isCompleted;

    return map;
  }


  Map toMAp(){
    var map=new Map<String,dynamic>();
    map[FireBaseConstants.startTime_constant]=startTime;
    map[FireBaseConstants.endTime_constant]=endTime;
    map[FireBaseConstants.memberKey_constant]=memberKey;
    map[FireBaseConstants.stepCount_constant]=stepCount;
    map[FireBaseConstants.calories_constant]=calories;
    map[FireBaseConstants.distance_constant]=distance;
    map[FireBaseConstants.walkingTime_constant]=walkingTime;
    map[FireBaseConstants.exerciseType_constant]=exerciseType;
    map[FireBaseConstants.isCompleted_constant]=isCompleted;

    return map;
  }


  ExerciseModel.fromJson(Map<String, dynamic> json) {
    this.startTime = json[FireBaseConstants.startTime_constant];
    this.endTime=json[FireBaseConstants.endTime_constant];
    this.memberKey=json[FireBaseConstants.memberKey_constant];
    this.stepCount = json[FireBaseConstants.stepCount_constant];
    this.calories=json[FireBaseConstants.calories_constant];
    this.distance=json[FireBaseConstants.distance_constant];
    this.walkingTime=json[FireBaseConstants.walkingTime_constant];
    this.exerciseType=json[FireBaseConstants.exerciseType_constant];
    this.isCompleted=json[FireBaseConstants.isCompleted_constant];
  }

  exerciseCompletedStatus(String completed,String uncompleted){
    return isCompleted?completed:uncompleted;
  }

  exerciseTypeStatus(String infinite,String exerciseTime){
    return exerciseType=="infinite"?infinite:exerciseTime;
  }


}
