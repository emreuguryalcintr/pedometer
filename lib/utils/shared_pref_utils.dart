import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils{

  static Future<void> setPefValue(String prefName,dynamic prefValue) async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    switch(prefValue.runtimeType){
      case int:
        preferences.setInt(prefName, prefValue);
        break;
      case double:
        preferences.setDouble(prefName, prefValue);
        break;
      case String:
        preferences.setString(prefName, prefValue);
        break;
      case bool:
        preferences.setBool(prefName, prefValue);
        break;

    }


  }

 static Future<String>  getPrefValue(String prefName) async{
  SharedPreferences preferences=await SharedPreferences.getInstance();
  return  preferences.get(prefName);
}

}