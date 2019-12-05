import 'package:flutter/cupertino.dart';

import 'daily_model.dart';

class GroupDailyModel{
  String date;
  int stepCount;
  double calories;
  double distance;

  GroupDailyModel({@required this.date, @required this.stepCount, @required this.calories, @required this.distance});


  static List<GroupDailyModel> groupDailyModelList(Map<String,List<DailyModel>> listDailyMap){

    List<GroupDailyModel> list=List();

    listDailyMap.forEach((key,value){
      GroupDailyModel model;
      double sumDistance=0;
      double sumCalories=0;
      int sumStepCount=0;

      value.forEach((dailyModel){
        sumDistance+=dailyModel.distance;
        sumCalories+=dailyModel.calories;
        sumStepCount+=dailyModel.stepCount;

      });

      model=GroupDailyModel(date: key, stepCount: sumStepCount, calories: sumCalories, distance: sumDistance);
      list.add(model);
      sumDistance=0;
      sumCalories=0;
       sumStepCount=0;
    });

    return list;
  }


}