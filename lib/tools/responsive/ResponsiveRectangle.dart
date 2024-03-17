
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:fastor_app_ui_widget/resource/template/listview/ListViewTemplate.dart';
import 'package:flutter/cupertino.dart';

/**
 Here the defaule page type is "portrait", what to do when responsive to landscape
 */
class ResponsiveToLandscape {

  /**
   * when there is image at background toolbarHome of mobile,
   * it's stratched when set to website,
   * to fix this make it's maximue is 500
   */
  static double fromMatchWidth_to_fixedWidth(BuildContext context){
    if( DeviceTools.isPlatformWeb() ) {
      //Log.i( "toolbar_width_image() - big");
      return 270;
    }

    return DeviceTools.getWidth( context );
  }


  /**
      - rule:
      +portrait:
      child1,
      child2
      +landscape:
      child1, child2

   - pages:
      "PaginateWidget" in page type "Portrait" make the direction of axis is vertical,
      while in page type is "Landscape"  make the direction of axis is vertical.

   */
  static portraitVertical_to_landscapeHorizontal(BuildContext context, {
    List<Widget> children = const <Widget>[]
  }) {
      if( DeviceTools.isPortrait( context) ) {
        return ListViewTemplate.t(context: context, children: children, axis: Axis.vertical);
      } else {
        return ListViewTemplate.t(context: context, children: children, axis: Axis.horizontal);
      }
  }


}