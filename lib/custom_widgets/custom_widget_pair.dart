import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';



class CustomWidgetPair extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String data;
  final String title;
  final double sizeBoxHeight;
  final TextStyle textStyle;

  CustomWidgetPair({this.iconColor,this.icon, this.data, this.title, this.sizeBoxHeight, this.textStyle});


  @override
  Widget build(BuildContext context) {
    return  Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Icon(icon,
          color: iconColor,),
        SizedBox(height: 5.0,),
        Text(data,style: textStyle!=null?textStyle:null,),
        SizedBox(height: 5.0,),
        if(title!=null) Text(title,style: textStyle!=null?textStyle:null,)
      ],
    );
  }
}
