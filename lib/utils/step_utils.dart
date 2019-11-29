
import 'dart:core' as prefix0;
import 'dart:core';

import 'package:denemee/utils/time_utils.dart';
import 'package:flutter/cupertino.dart';

getTitleList({@required List<String> titleDatesList,@required String dateConstantName,@required var singleDocumentItem}){
  if(!titleDatesList.contains(convertDateFromTimeStamps(singleDocumentItem[dateConstantName]))){
    titleDatesList.add(convertDateFromTimeStamps(singleDocumentItem[dateConstantName]));
  }

  return titleDatesList;
}