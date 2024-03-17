import 'package:shared_preferences/shared_preferences.dart';


class CheckSocketFoundController {


  static const  String  _keyCacheLastSocketBackgrond = "_keyCacheLastSocketBackgrond";

  static Future setLastFireSocketBackground(  int v) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_keyCacheLastSocketBackgrond, v);

  }


  static Future<int> getLastFireSocketBackground(  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var result = prefs.getInt(_keyCacheLastSocketBackgrond) ?? 0 ;
    return result;
  }

  // static Future <bool> isO
}