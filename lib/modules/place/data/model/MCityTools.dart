import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/modules/product/data/model/MCategory.dart';
import 'package:umq/modules/place/data/model/MCity.dart';

class MCityTools {

  static String getNameByLang(BuildContext context, MCity? m ) {
    if( m == null )return"";
    if( LanguageTools.isArabic(context) ) {
      return m.name_ar??"" ;
    } else {
      return m.name_en??"";
    }
  }

  static MCity getModelById( List<MCity> list, int? city_id) {

    if( city_id == null ) return MCity();
    Log.i( "getModelById() - city_id "   + city_id.toString( )  );
    for ( int i = 0 ; i < list.length ; i++ ) {
      MCity m = list[i];
      if( m == null ) continue;
      Log.i( "getModelById() - m "   + m.toString( )  );

      if( m.id == null ) continue;
      if( m.id.toString() == city_id ) return m;
    }
    return MCity();
  }


}