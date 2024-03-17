

class ToolsPrice {

  static String prefixString(String? org  ) {
    if( org == null  ) return "0.0 SR";

    //prefix
    return org.toString() + " SR";
  }

  static String prefixDouble(double? org  ) {
    if( org == null  ) return "0.0 SR";

    //prefix
    return org.toString() + " SR";
  }

  static String prefix(int? org  ) {
    if( org == null  ) return "0 SR";

    //prefix
    return org.toString() + " SR";
  }


  static String removeFraction(String? org  ) {
    if( org == null  ) return "0";

    //get fraction
    double d = double.parse( org );
    var integer = _roundToPlus1 ( d );

    //prefix
    return prefix( integer);
  }



  /**
   * means plus 1 . in case "2.333" round to "3.0"
   */
  static int _roundToPlus1(double row_counter ){
    //round
    double fraction =  row_counter -  row_counter.truncate();// '2.3555' >> "0.3555"
    if( fraction > 0.0 ) {
      row_counter = row_counter + 1 - fraction;
    }
   // Log.i("gridview - t() - row_counter: $row_counter ");
    return row_counter.toInt();
  }
}