import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denemee/constants/firebase_constants.dart';
import 'package:denemee/localization/localization_constants.dart';
import 'package:denemee/custom_libraries/easy_localization/custom_app_localizations.dart';
import 'package:denemee/custom_widgets/step_analyse_list_item.dart';
import 'package:denemee/localization/localization_initial_constants.dart';
import 'package:denemee/localization/localization_initial_constants.dart' as prefix0;
import 'package:denemee/models/exercise_model.dart';
import 'package:denemee/pages/detail/detail_exercise.dart';
import 'package:denemee/styles/text_styles.dart';
import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:denemee/custom_widgets/build_group_separator.dart';

class AnalysisListPage extends StatefulWidget {
  @override
  _AnalysisListPageState createState() => _AnalysisListPageState();
}

class _AnalysisListPageState extends State<AnalysisListPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: localizationDelegates(),
      localeResolutionCallback: prefix0.localeResolutionCallback(),
      supportedLocales: supportedLanguages(),
      home: Padding(
          padding: EdgeInsets.all(8.0),
          child: Container(
            child: StreamBuilder(
              stream: Firestore.instance
                  .collection(FireBaseConstants.dbName_exercise)
                  .orderBy(FireBaseConstants.startTime_constant, descending: true)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                    Text(AppLocalizations.of(context).translate(LocalizationConstants.please_wait),style: textStyleTitle(),)
                      ],
                    ),
                  );
                }
                var items = snapshot.data.documents;

                switch (snapshot.connectionState) {
                  case ConnectionState.none:

                  case ConnectionState.waiting:
                    return Center(
                      child:  Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          Text(AppLocalizations.of(context).translate(LocalizationConstants.please_wait),style: textStyleTitle(),)
                        ],
                      ),
                    );

                  default:
                    return GroupedListView(
                      elements: items,
                      groupBy: (element) => convertDateFromTimeStamps(
                          element[FireBaseConstants.startTime_constant]),
                      groupSeparatorBuilder: buildGroupSeparator,
                      sort: false,
                      itemBuilder: (context, element) {
                        return GestureDetector(
                          child: StepAnalyseListItem(
                            calories:
                                element[FireBaseConstants.calories_constant]
                                    .toString(),
                            distance:
                                element[FireBaseConstants.distance_constant]
                                    .toString(),
                            stepSize:
                                element[FireBaseConstants.stepCount_constant]
                                    .toString(),
                            date: convertDateFromTimeStamps(
                                element[FireBaseConstants.startTime_constant]),
                          ),
                          onTap: () {
                            ExerciseModel exerciseModel = new ExerciseModel(
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
                                    FireBaseConstants.walkingTime_constant],
                                exerciseType: element[
                                    FireBaseConstants.exerciseType_constant],
                                isCompleted: element[
                                    FireBaseConstants.isCompleted_constant]);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetailExercisePage(
                                          exerciseModel: exerciseModel,
                                        )));
                          },
                        );
                      },
                    );
                }
              },
            ),
          )),
    );
  }

}
