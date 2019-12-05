import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';

class DailyModel {
  Timestamp startTime;
  Timestamp endTime;
  String memberKey;
  int stepCount;
  double calories;
  double distance;
  int walkingTime;



  DailyModel({@required this.startTime, @required this.endTime, @required this.memberKey, @required this.stepCount,
    @required this.calories, @required this.distance, @required this.walkingTime});

  Map toMAp(){
    var map=new Map<String,dynamic>();
    map[FireBaseConstants.startTime_constant]=startTime;
    map[FireBaseConstants.endTime_constant]=endTime;
    map[FireBaseConstants.memberKey_constant]=memberKey;
    map[FireBaseConstants.stepCount_constant]=stepCount;
    map[FireBaseConstants.calories_constant]=calories;
    map[FireBaseConstants.distance_constant]=distance;
    map[FireBaseConstants.walkingTime_constant]=walkingTime;

    return map;
  }


  DailyModel.fromJson(Map<String, dynamic> json) {
    this.startTime = json[FireBaseConstants.startTime_constant];
    this.endTime=json[FireBaseConstants.endTime_constant];
    this.memberKey=json[FireBaseConstants.memberKey_constant];
    this.stepCount = json[FireBaseConstants.stepCount_constant];
    this.calories=json[FireBaseConstants.calories_constant];
    this.distance=json[FireBaseConstants.distance_constant];
    this.walkingTime=json[FireBaseConstants.walkingTime_constant];
  }

  static Map dailyListByDay(List<DailyModel> listFromFireStore){
    print("dailyListByDay size: ${listFromFireStore.length}");

    /**
     * burada ilk string değeri bugün bu hafta ya da bu ay olup olmadığını belirleyecek
     *  Map<String,Map> mapToHeader=Map();
     */


    Map<String,List<DailyModel>> mapByDay=Map();
    String dateInString="";
    List<DailyModel> list=new List();

    for(int i=0;i<listFromFireStore.length;i++){
      dateInString=convertDateFromTimeStamps(listFromFireStore[i].startTime);
      print("dailyListByDay date : $dateInString");
      if(i==0){
        list.add(listFromFireStore[0]);
        mapByDay[dateInString]=list;

      }else{
          if(mapByDay.containsKey(dateInString)){
            list.add(listFromFireStore[i]);
            mapByDay[dateInString]=list;
          }else{
            list=List();
            list.add(listFromFireStore[i]);
            mapByDay[dateInString]=list;
          }

      }
    }

    return mapByDay;
  }

  @override
  String toString() {
    return 'DailyModel{ stepCount: $stepCount, calories: $calories, distance: $distance, walkingTime: $walkingTime}';
  }


}
