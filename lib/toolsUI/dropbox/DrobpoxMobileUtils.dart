import 'package:flutter/material.dart';
import 'package:umq/toolsUI/ThemeColor.dart';

class DrobpoxMobileUtils {


  static BoxDecoration getBoxDecoration(){
    return BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(50.0)),
        color: Colors.white.withOpacity(.5),
        border: Border.all(color: ThemeColor.colorSecoundry,width: 1 )
    );
  }


}
