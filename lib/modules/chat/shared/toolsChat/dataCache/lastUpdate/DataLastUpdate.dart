
import 'package:shared_preferences/shared_preferences.dart';


class DataLastUpdate {



//------------------------------------------------------------------- last update at socket

  /**
      used this variable just to save for log testing
   */

  // static const  String  _keyCacheLastUpdate = "_keyCacheLastUpdate";
  //
  // static Future setLastUpdateSocket(  int v) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_keyCacheLastUpdate, v);
  //
  // }
  //
  //
  // static Future<int> getLastUpdateSocket(  ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var result = prefs.getInt(_keyCacheLastUpdate) ?? 0 ;
  //   return result;
  // }

  //------------------------------------------------------------------- first time install app
  //
  // /**
  //  * used this to determine if the user first time open page chat after install application
  //  * now do process of dowload the history of user list
  //  */
  // static const  String  _keyCacheFirstTimeInstallApp = "_keyCacheFirstTimeInstallApp";
  //
  // @Deprecated( "Wait for version sql offline")
  // static Future setFirstTimeInstallApp( bool v) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setBool(_keyCacheFirstTimeInstallApp, v);
  //
  // }
  //
  //
  // @Deprecated( "Wait for version sql offline")
  // static Future<bool> getFirstTimeInstallApp(  ) async {
  //   /**
  //    * not default is "true'
  //    */
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var timestamp = prefs.getBool(_keyCacheFirstTimeInstallApp) ?? true ;
  //   return timestamp;
  // }


  //------------------------------------------------------------------- sync data
  //
  // static const  String  _keyCacheSyncData = "keyCacheSyncData";
  //
  // @Deprecated( "Wait for version sql offline")
  // static Future setCompleteSyncDate(  int timestamp) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setInt(_keyCacheSyncData, timestamp);
  //
  // }
  //
  // @Deprecated( "Wait for version sql offline")
  // static Future<int> getCompleteSyncDate(  ) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   var timestamp = prefs.getInt(_keyCacheSyncData) ?? 0 ;
  //   return timestamp;
  // }




}