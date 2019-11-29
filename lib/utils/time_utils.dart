
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

var format_onlyDate=DateFormat("dd.MM.yyyy");
var format_onlyMonthAndYear=DateFormat("MM.yyyy");
var format_onlyDay=DateFormat("dd");
var format_dateAndTime=DateFormat("hh.mm \n dd.MM.yyyy");
var format_walkingtime=DateFormat("h : mm : s");

timeToDisplayStopwatch(Stopwatch stopwatch){

  return stopwatch.elapsed.inHours.toString().padLeft(2,"0")+":"+
      (stopwatch.elapsed.inMinutes%60).toString().padLeft(2,"0")+":"+
      (stopwatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
}



displayTimeInMills(Stopwatch stopwatch){
  return stopwatch.elapsed.inMilliseconds;
}

getNowDate(){
  var now = new DateTime.now();
  return now.day.toString()+"."+now.month.toString()+"."+now.year.toString();
}

getDateDifference({int day=0,int month=0,int year=0}){
  var now = new DateTime.now();
  return (now.day+day).toString()+"."+(now.month+month).toString()+"."+(now.year+year).toString();
}

getNowHour(){
  var now = new DateTime.now();
  return now.hour.toString();
}

getTimeInMills(){
  var now=DateTime.now();
  return now.millisecondsSinceEpoch;
}

getWalkingTimeInSeconds(Stopwatch stopwatch){
  return stopwatch.elapsed.inSeconds;
}

convertWalkingTimeToFormat(int timeInSeconds){
  final DateTime timeStamp = DateTime.fromMillisecondsSinceEpoch(timeInSeconds*1000);
  return timeStamp.hour.toString().padLeft(2,"0")+":"+
      timeStamp.minute.toString().padLeft(2,"0")+":"+
      timeStamp.second.toString().padLeft(2,"0");
}


convertDateFromTimeStamps(Timestamp timeStamps){
  var date=DateTime.fromMillisecondsSinceEpoch(timeStamps.millisecondsSinceEpoch);
  return format_onlyDate.format(date);
}

convertDayFromTimeStamps(Timestamp timeStamps){
  var date=DateTime.fromMillisecondsSinceEpoch(timeStamps.millisecondsSinceEpoch);
  return format_onlyDay.format(date).toString();
}

convertDateAndTimeFromTimestamps(Timestamp timestamp,{DateFormat format}){
  var dateTime=DateTime.fromMillisecondsSinceEpoch(timestamp.millisecondsSinceEpoch);
  return format.format(dateTime);
}

getDateStamps(String date){
 return Timestamp.fromMillisecondsSinceEpoch(format_onlyDate.parse(date).millisecondsSinceEpoch);

}

convertWalkingTime(int walkingTime){

  int seconds=walkingTime%60;
  int minutes=(walkingTime~/60)%60;
  int hours=walkingTime~/3600;

  return hours.toString().padLeft(2,"0")+":"+minutes.toString().padLeft(2,"0")+":"+seconds.toString().padLeft(2,"0");
}



