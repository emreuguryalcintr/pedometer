

timeToDisplay(Stopwatch stopwatch){
  return stopwatch.elapsed.inHours.toString().padLeft(2,"0")+":"+
      (stopwatch.elapsed.inMinutes%60).toString().padLeft(2,"0")+":"+
      (stopwatch.elapsed.inSeconds%60).toString().padLeft(2,"0");
}

displayTimeInMills(Stopwatch stopwatch){
  return stopwatch.elapsed.inMilliseconds;
}