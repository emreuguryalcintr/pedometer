import 'package:denemee/constants/general_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String platformName(BuildContext context) {
  String platformName = "";
  if (Theme
      .of(context)
      .platform == TargetPlatform.android) {
    platformName = GeneralConstants.PLATFORM_ANDROID;
  }
//do sth for Android
  else if (Theme
      .of(context)
      .platform == TargetPlatform.iOS) {
    platformName = GeneralConstants.PLATFORM_ANDROID;
  }
//do sth else for iOS
  else if (Theme
      .of(context)
      .platform == TargetPlatform.fuchsia){
  platformName= GeneralConstants.PLATFORM_ANDROID;


  }
  return platformName;
  }

