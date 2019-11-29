import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/custom_widgets/build_group_separator.dart';
import 'package:denemee/custom_widgets/step_analyse_list_item.dart';
import 'package:denemee/models/daily_model.dart';
import 'package:denemee/pages/detail/detail_exercise.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

class AnalysisGraphicallyPage extends StatefulWidget {
  @override
  _AnalysisGraphicallyPageState createState() =>
      _AnalysisGraphicallyPageState();
}

class _AnalysisGraphicallyPageState extends State<AnalysisGraphicallyPage> {
  List<DailyModel> dailyModelList;
  List<String> titleDates;
  int sum = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    dailyModelList = List();
    titleDates=List();
  }

  getData() {
    print('today : ${getDateStamps(getNowDate())}');
    print('tomorrow : ${getDateStamps(getDateDifference(day: 1))}');

    return Firestore.instance
        .collection(FireBaseConstants.dbName_daily)
        .orderBy(FireBaseConstants.startTime_constant,descending: true)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: getData(),
        builder: (context, snapShot) {
          if (!snapShot.hasData) return Text("Lütfen bekleyiniz");

          var documents = snapShot.data.documents;
          switch (snapShot.connectionState) {
            case ConnectionState.none:

            case ConnectionState.waiting:
              return Center(
                child:  Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("Lütfen bekleyiniz...")
                  ],
                ),
              );

            default:
              return GroupedListView(
                elements: documents,
                groupBy: (element) => convertDateAndTimeFromTimestamps(
                    element[FireBaseConstants.startTime_constant],format: format_onlyMonthAndYear),
                groupSeparatorBuilder: buildGroupSeparator,
                sort: false,
                itemBuilder: (context, element) {
                  return GestureDetector(

                    child: StepAnalyseListItem(
                      date: convertDateFromTimeStamps(
                          element[FireBaseConstants.startTime_constant]),
                      distance: element[FireBaseConstants.distance_constant]
                          .toString(),
                      calories: element[FireBaseConstants.calories_constant]
                          .toString(),
                      stepSize: element[FireBaseConstants.stepCount_constant]
                          .toString(),
                    ),
                    onTap: () {
                      DailyModel dailyModel = new DailyModel(
                          startTime:
                          element[FireBaseConstants.startTime_constant],
                          endTime:
                          element[FireBaseConstants.endTime_constant],
                          memberKey:
                          element[FireBaseConstants.memberKey_constant],
                          stepCount:
                          element[FireBaseConstants.stepCount_constant],
                          calories:
                          element[FireBaseConstants.calories_constant],
                          distance:
                          element[FireBaseConstants.distance_constant],
                          walkingTime: element[
                          FireBaseConstants.walkingTime_constant],);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DetailExercisePage(
                                dailyModel: dailyModel,
                              )));
                    },
                  );
                },
              );
          }

        },
      ),
    );
  }
}
