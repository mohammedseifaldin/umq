import 'package:flutter/material.dart';

class ChatDrawable {


  //images
  static AssetImage images(String nameImage ) {
    AssetImage  ass  = AssetImage( "assets/chat/" + nameImage + ".png");
    return ass;
  }


}