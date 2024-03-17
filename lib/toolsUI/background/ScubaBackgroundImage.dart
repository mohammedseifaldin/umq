import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ScubaBackgroundImage   {

  static Widget getImageResponsive(BuildContext context ) {
    if( DeviceTools.isPortrait(context) ) {
      return im_background_portial(context);
    } else {
      return im_background_landscape(context);
    }
  }


  static Widget im_background_portial(BuildContext context ) {
    return ImageView(width:  DeviceTools.getWidth( context),
      height:  DeviceTools.getHeight(  context ),

      assetBackground: DrawableProject.images_with_extension( "background_auth.jpeg" ),
    );
  }


  static  Widget im_background_landscape(BuildContext context ){
    return ImageView(width:  DeviceTools.getWidth(  context),
      height:  DeviceTools.getHeight(  context ),
      assetBackground: DrawableProject.images_with_extension( "background_auth_landscape.jpeg" ),
    );
  }
}

