import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/localization/localization_constants.dart';
import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart' as customLocalization;
import 'package:denemee/custom_widgets/build_group_separator.dart';
import 'package:denemee/custom_widgets/step_analyse_list_item.dart';
import 'package:denemee/localization/localization_initial_constants.dart';
import 'package:denemee/models/daily_model.dart';
import 'package:denemee/models/group_daily_model.dart';
import 'package:denemee/pages/detail/detail_exercise.dart';
import 'package:denemee/styles/text_styles.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:grouped_list/grouped_list.dart';




class AnalysisDailyPage extends StatefulWidget {
  @override
  _AnalysisDailyPageState createState() =>
      _AnalysisDailyPageState();
}

class _AnalysisDailyPageState extends State<AnalysisDailyPage> {
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
    List<GroupDailyModel> groupDailyModel;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates:localizationDelegates(),
      supportedLocales:supportedLanguages(),
      localeResolutionCallback: localeResolutionCallback(),

      home: Container(
        child: StreamBuilder(
          stream: getData(),
          builder: (context, snapShot) {
            if (!snapShot.hasData) return Text(customLocalization.AppLocalizations.of(context).translate(LocalizationConstants.please_wait),style: textStyleTitle(),);


            var documents = snapShot.data.documents;

            print('documents.length ${documents.length}');

            documents.forEach((document){
              dailyModelList.add(DailyModel(
                startTime: document[FireBaseConstants.startTime_constant],
                endTime:
                document[FireBaseConstants.endTime_constant],
                memberKey:
                document[FireBaseConstants.memberKey_constant],
                stepCount:
                document[FireBaseConstants.stepCount_constant],
                calories:
                document[FireBaseConstants.calories_constant],
                distance:
                document[FireBaseConstants.distance_constant],
                walkingTime: document[
                FireBaseConstants.walkingTime_constant],));
            });


            groupDailyModel=GroupDailyModel.groupDailyModelList(DailyModel.dailyListByDay(dailyModelList));



            switch (snapShot.connectionState) {
              case ConnectionState.none:

              case ConnectionState.waiting:
                return Center(
                  child:  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      Text(customLocalization.AppLocalizations.of(context).translate(LocalizationConstants.please_wait),style: textStyleTitle(),)
                    ],
                  ),
                );

              default:
                return GroupedListView(
                  elements: groupDailyModel,
                  groupBy: (element) =>element.date,
                  groupSeparatorBuilder: buildGroupSeparator,
                  sort: false,
                  itemBuilder: (context, element) {

                    print("list size in grouped list view: ${dailyModelList.length}");
                    return GestureDetector(

                      child: StepAnalyseListItem(
                        date: element.date,
                        distance: element.distance.toString(),
                        calories: element.calories.toString(),
                        stepSize: element.stepCount.toString(),
                      ),
                      onTap: () {
                        /*DailyModel dailyModel = new DailyModel(
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
*/
                      },
                    );
                  },

                );
            }

          },
        ),
      ),
    );
  }
}
