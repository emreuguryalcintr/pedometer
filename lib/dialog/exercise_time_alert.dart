import 'package:denemee/custom_widgets/duration_widget/flutter_duration_picker.dart';
import 'package:denemee/custom_widgets/start_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseTimeAlert extends StatefulWidget {
  final GestureTapCallback onPressedStart;
  final GestureTapCallback onPressedCancel;
  final Duration duration;


  ExerciseTimeAlert({@required this.onPressedStart,@required this.onPressedCancel,@required this.duration});

  ExerciseTimeAlert.empty({this.onPressedStart,this.onPressedCancel, this.duration});

  @override
  _ExerciseTimeAlertState createState() => _ExerciseTimeAlertState();
}

class _ExerciseTimeAlertState extends State<ExerciseTimeAlert> {
  Duration _duration;
  int selectedRadio=1;
  int timeInSeconds=0;

  @override
  void initState() {
    super.initState();
    selectedRadio = 1;
    _duration=widget.duration;

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
                      },
                    ),
                    Text("Süresiz Egzersiz")
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
                      },
                    ),
                    Text("Süreli Egzersiz")
                  ],
                ),
              ],
            ),
           _alertSelectedWidget()
           ,

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                WidgetStartExerciseButton(
                  text: "Başlat",
                  onPressed: widget.onPressedStart,
                ),
                WidgetStartExerciseButton(
                  text: "İptal",
                  onPressed: widget.onPressedCancel,
                ),
              ],
            ),
            SizedBox(height: 20.0,)

          ],
        ),
      ),
    );
  }

  Widget _alertSelectedWidget(){
    switch(selectedRadio){
      case 2:
        return  DurationPicker(
          duration: _duration,
          colorAccent: Colors.cyan,
          onChange: (Duration value) {
            setState(() {
              this._duration=value;
            });
          },
          snapToMins: 1,
        );

      default:

        return Text("sınırsız ezgersiz");
    }
  }
}
