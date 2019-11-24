import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ExerciseTimeSelectWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Text("Saat"),
                SizedBox(height: 5.0,),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(width: 0.0, color: Colors.black)),
                  contentPadding: EdgeInsets.all(5.0),
                  hintText:"Saat"),

                )
              ],
            ),
          ),
          SizedBox(width: 5.0,),
          Expanded(
            flex: 1,
            child: Column(
              children: <Widget>[
                Text("Dakika"),
                SizedBox(height:5.0),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: new InputDecoration(
                      border: OutlineInputBorder(
                          borderSide:
                          BorderSide(width: 0.0, color: Colors.black)),
                      contentPadding: EdgeInsets.all(5.0),
                      hintText:"Dakika"),


                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
