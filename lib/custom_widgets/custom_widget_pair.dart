import 'package:flutter/cupertino.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CustomWidgetPair extends StatelessWidget {
  final Color iconColor;
  final IconData icon;
  final String data;
  final String title;
  final double sizeBoxHeight;
  final TextStyle textStyle;
  final double iconSize;

  CustomWidgetPair(
      {this.iconColor,
      this.icon,
      this.data,
      this.title,
      this.sizeBoxHeight,
      this.textStyle,
      this.iconSize});

  bool notNull(Object o) => o != null;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        iconSize == null
            ? Icon(icon, color: iconColor)
            : Icon(
                icon,
                color: iconColor,
                size: iconSize,
              ),
        SizedBox(
          height: 5.0,
        ),
        Text(
          data,
          style: textStyle != null ? textStyle : null,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 5.0,
        ),
        title != null
            ? Text(
                title,
                style: textStyle != null ? textStyle : null,
              )
            : null
      ].where(notNull).toList(),
    );
  }
}
