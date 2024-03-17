import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';

/**
 * the orginal here is set the orginal size of "Mobile" screens
 *
 */
class Responsive {

  /**
   * untill today not make any edition
   */
  static double designSystem(double d ) {
    return d;
  }

  /**
   * - function:
   * this item size convert from mobile to website

      - pages:
   *     if( DeviceTools.isMobile() ) {
      return DeviceTools.getHalfWidth();
      }
      return DeviceTools.getSixthWidth();
   */
  static double horizontalListItem(double org) {
    if( DeviceTools.isMobile() ) {
      return org;
    }
    var integer = org * 0.33;
    return integer.toDouble();
  }

  /**
   * - function:
   we need to show the content in size of mobile frame,
      - pages:
        the login form the width of this form in mobile take full width,
        while in web need to me small to be like mobile
   */
  static dynamic getWidthMobileForEver(BuildContext context) {
    if( DeviceTools.isMobile( )  || DeviceTools.isBrowserMobile() ) {
      return DeviceTools.getWidth(context);
    }
    if( DeviceTools.isLandscape(context) ) {
      return DeviceTools.getPercentageWidth(context, 50);
    }
    return 350;
  }



}