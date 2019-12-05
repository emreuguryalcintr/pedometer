import 'package:denemee/constants/general_constants.dart';
import 'package:denemee/custom_widgets/start_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:denemee/custom_widgets/duration_widget/flutter_duration_picker.dart';

class ExerciseTimeAlert extends StatefulWidget {
  final GestureTapCallback onPressedStart;
  final GestureTapCallback onPressedCancel;
  final Duration duration;
  final Function(dynamic durationValue) durationData;
  final Function(String exerciseType) exerciseType;
  final String startText;
  final String cancelText;
  final String finiteExerciseText;
  final String infiniteExerciseText;
  final String shortMin;
  final String shortHour;

  ExerciseTimeAlert({
    @required this.onPressedStart,
    @required this.onPressedCancel,
    @required this.duration,
    @required this.durationData,
    @required this.exerciseType,
    @required this.startText,
    @required this.cancelText,
    @required this.finiteExerciseText,
    @required this.infiniteExerciseText,
    @required this.shortMin,
    @required this.shortHour,
  });

  @override
  _ExerciseTimeAlertState createState() => _ExerciseTimeAlertState();
}

class _ExerciseTimeAlertState extends State<ExerciseTimeAlert> {
  Duration _duration;
  int selectedRadio = 1;
  int timeInSeconds = 0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
    _duration = widget.duration;
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.amber,
      child: dialogContext(context),
    );
  }

  dialogContext(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: selectedRadio,
                      activeColor: Colors.white,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                        widget.exerciseType(
                            GeneralConstants.EXERCISE_TYPE_INFINITE);
                      },
                    ),
                    Text(widget.infiniteExerciseText)
                  ],
                ),
                Column(
                  children: <Widget>[
                    Radio(
                      value: 2,
                      groupValue: selectedRadio,
                      activeColor: Colors.white,
                      onChanged: (val) {
                        print("Radio $val");
                        setSelectedRadio(val);
                        widget.exerciseType(
                            GeneralConstants.EXERCISE_TYPE_FINITE);
                      },
                    ),
                    Text(widget.finiteExerciseText)
                  ],
                ),
              ],
            ),
            _alertSelectedWidget(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                WidgetStartExerciseButton(
                  text: widget.startText,
                  onPressed: widget.onPressedStart,
                ),
                WidgetStartExerciseButton(
                  text: widget.cancelText,
                  onPressed: widget.onPressedCancel,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            )
          ],
        ),
      ),
    );
  }

  Widget _alertSelectedWidget() {
    switch (selectedRadio) {
      case 2:
        return DurationPicker(
          shortHour: widget.shortHour,
          shortMin: widget.shortMin,
          duration: _duration,
          colorAccent: Colors.cyan,
          onChange: (Duration value) {
            setState(() {
              this._duration = value;
              widget.durationData(_duration.inSeconds);
            });
          },
          snapToMins: 1,
        );

      default:
        return Text(widget.infiniteExerciseText);
    }
  }
}
