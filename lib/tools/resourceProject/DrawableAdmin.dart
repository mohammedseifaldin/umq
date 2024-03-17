import 'package:flutter/material.dart';

class DrawableAdmin {

  static String path = "assets/admin/";


  //pages of images
  static AssetImage admin_post_list = AssetImage( "assets/admin/admin_post_list.jpg");

  //arrow (left/right)
  static AssetImage arrow_left = AssetImage( "assets/admin/arrow_left.png");
  static AssetImage arrow_right = AssetImage( "assets/admin/arrow_right.png");
  static AssetImage arrow_left_light = AssetImage( "assets/admin/arrow_left_light.png");
  static AssetImage arrow_right_light = AssetImage( "assets/admin/arrow_right_light.png");

  //arrow (up/down)
  static AssetImage arrow_up_light = AssetImage( "assets/admin/arrow_up_light.png");
  static AssetImage arrow_down_light = AssetImage( "assets/admin/arrow_down_light.png");

  //search
  static AssetImage icon_search = AssetImage( path + "icon_search.jpg" );

  static AssetImage image(String nameImage ) {
    AssetImage  ass  = AssetImage( "assets/admin/" + nameImage + ".png");
    return ass;
  }

}