
import 'package:intl/intl.dart';



class TimeTools {


  //----------------------------------------------------------------- current time

  /**
   * https://stackoverflow.com/a/62233947/7186671
   * 1654721784
   *
   * return micro
   * 1654732024000
   */
  static int getCurrentTimestamp() {
    // int numberWith1000 =  new DateTime.now().millisecondsSinceEpoch;
    var dateUtc = DateTime.now().toUtc();
    int numberWith1000 = dateUtc.millisecondsSinceEpoch;
    String num_str = numberWith1000.toString();
    int len = num_str.length;
    String cut1000 =  num_str.substring( 0 , len- 3 );
    return int.parse( cut1000 );
  }

  /**
   * return typeRelation: hh:mm:ss:iii
   * pages:  03:09:06:009
   */
  static String getCurrent__hhmmssiii() {
    DateTime now = DateTime.now();

    //h
    String h = now.hour.toString();
    if(  now.hour < 10 ) {
      h = "0" + now.hour.toString();
    }

    //m
    String m = now.minute.toString();
    if(  now.minute < 10 ) {
      m = "0" + now.minute.toString();
    }

    //s
    String s = now.second.toString();
    if(  now.second < 10 ) {
      s = "0" + now.second.toString();
    }

    //i
    String i = now.millisecond.toString();
    if(  now.millisecond < 10 ) {
      i = "00" + now.millisecond.toString();
    } else if(  now.millisecond < 100 ) {
      i = "0" + now.millisecond.toString();
    }

    String timeStr = h + ":" + m + ":" + s + ":" + i ;
    return timeStr;
  }

  //------------------------------------------------------------------ convert from timestamp

  static String timestampToDate_hh_mm(int? millis ) {
    if( millis == null ) return "";

    //fix not thousends "1646603713" need to be "1646603713000"
    var st = "" + millis.toString();
    if( st.length <= 10 ){
      millis = millis * 1000;
    }

    //convert
    var dateNeeded = DateTime.fromMillisecondsSinceEpoch(millis);
   // Log.i("timestampToDate_hh_mm() - dateNeeded: " + dateNeeded.toString() + " /milis: " + millis.toString()  );

    //h
    String h = dateNeeded.hour.toString();
    if(  dateNeeded.hour < 10 ) {
      h = "0" + dateNeeded.hour.toString();
    }

    //m
    String m = dateNeeded.minute.toString();
    if(  dateNeeded.minute < 10 ) {
      m = "0" + dateNeeded.minute.toString();
    }

    //s
    String s = dateNeeded.second.toString();
    if(  dateNeeded.second < 10 ) {
      s = "0" + dateNeeded.second.toString();
    }

    //i
    String i = dateNeeded.millisecond.toString();
    if(  dateNeeded.millisecond < 10 ) {
      i = "00" + dateNeeded.millisecond.toString();
    } else if(  dateNeeded.millisecond < 100 ) {
      i = "0" + dateNeeded.millisecond.toString();
    }

    String timeStr = h + ":" + m   ;
    return timeStr;
  }


  //see https://stackoverflow.com/a/61100661/7186671
  //use "https://pub.dev/packages/intl"
  static String convertTimestamp_yyymmddhhmmPM(int millis) {
    if( millis == null ) return "";

    //fix not thousends "1646603713" need to be "1646603713000"
    var st = "" + millis.toString();
    if( st.length <= 10 ){
      millis = millis * 1000;
    }

    var date = DateTime.fromMillisecondsSinceEpoch(millis);

    //day is 12 hour
    var day12Hour = DateFormat('dd/MM/yyyy, hh:mm a').format(date); //example:  // 12/31/2000, 10:00 PM
    return day12Hour;
  }

  //-------------------------------------------------------------------- date reformat

  static String  dataFromLaravelToAmerican(String? dataLaravel ){
    if( dataLaravel  == null ) { return ""; }
    return dataLaravel ;
  }
   



  //------------------------------------------------------------------- checker date is

  static bool isToday(int dateToCheck ) {
    // one day
    int current = TimeTools.getCurrentTimestamp();
    int oneDay = 60*60*24;
    int dif = current - dateToCheck  ;
 //   Log.i( "getHumanDate() - oneDay " + oneDay.toString() + " /dif: " + dif.toString()  );
    return dif < oneDay ;
  }


  static bool isYesterday(int dateToCheck ) {
    // one day
    int current = TimeTools.getCurrentTimestamp();
    int oneDay = 60*60*24;
    int dif = current - dateToCheck  ;
  //  Log.i( "getHumanDate() - oneDay " + oneDay.toString() + " /dif: " + dif.toString()  );
    return dif < (oneDay * 2) ;
  }





}