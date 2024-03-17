


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
 
import 'package:flutter/cupertino.dart';


import '../Responsive.dart';

/**
 * ResponsiveFormMobile used for toolsUI mobile to be good shape in website
 */

class ResponsiveFourmMobile  {

  //------------------------------------------------------------------ wrap height

  static Widget wrapHeight(BuildContext context, Widget content ) {
    //check default mobile
    if( DeviceTools.isPortrait( context) ) {
      return content;
    }

    //stack
    var stack =  StackTemplate.AlignParentPage( context: context,
        alignCenterTop: _cardViewWrap( context, content )
    );

    //margin to parent
    return Container(child: stack,
        margin: EdgeInsets.all(DSDimen.space_parent)
    );
  }

  static Widget _cardViewWrap(BuildContext context, Widget content ) {

    //card
    return Container( child:  content,
      width: Responsive.getWidthMobileForEver( context),
      decoration: DeviceTools.isPlatformWeb()? BoarderHelper.cardViewShadow() : null ,
    );
  }

  //------------------------------------------------------------------ fixed height

  static Widget fixedHeight(BuildContext context, Widget content, double height ) {
    //check default mobile
    if( DeviceTools.isPortrait( context ) ) {
      return content;
    }

    var stack =  StackTemplate.AlignParentPage( context: context,
        alignCenterTop: _cardviewFixedHeight( context, content,  height)
    );

    //margin to parent
    return Container(child: stack,
    margin: EdgeInsets.all(DSDimen.space_parent)
    );
  }


  static Widget _cardviewFixedHeight( BuildContext context, Widget child, double height){

    return CardViewTemplate.t(
      child:   child  ,
      width: Responsive.getWidthMobileForEver( context ),
      height: height,
      radius_all: DSDimen.ds_size_corner_level_2,
      elevationValue: DSDimen.elevation_level_2,
    );
  }

}