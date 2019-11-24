class StepModel {
  int stepCount;
  int dateTime;
  double calories;
  double distance;
  int walkingTime;
  String exerciseType;
  bool isCompleted;


  StepModel(this.stepCount, this.dateTime, this.calories, this.distance, this.walkingTime, this.exerciseType, this.isCompleted);

  Map toMAp(){
    var map=new Map<String,dynamic>();
    map['step_count']=stepCount;
    map['date_time']=dateTime;
    map['exercise_type']=exerciseType;
    map['is_completed']=isCompleted;
    map['calories']=calories;
    map['distance']=distance;

    return map;
  }


  StepModel.fromJson(Map<String, dynamic> json) {
    this.stepCount = json['step_count'];
    this.dateTime = json['date_time'];
    this.exerciseType = json['exercise_type'];
    this.isCompleted=json['is_completed'];
    this.calories=json['calories'];
    this.distance=json['distance'];
  }

}
