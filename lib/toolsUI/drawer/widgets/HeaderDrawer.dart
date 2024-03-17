import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/drawer/DrawerUmqWidget.dart';

extension HeaderDrawer on DrawerUmqWidget {


  Widget header(){
    return Container(
      child: photoAndUsername(),
      decoration: BoarderHelper.rounded(
        // radiusSize: 15,
        colorBackground: HexColor( ColorProject.blue_fish_back),
        radiusBorder: BorderRadiusTools.get(
          radius_bottomLeft: 15,
          radius_bottomRight: 15,
        )
      ),
      padding: EdgeInsets.only(top: 50, bottom: 50, left: 20, right: 20),
    );
  }


  Widget photoAndUsername(){
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          photo(),
          username()
    ]);
  }


  Widget photo() {
    return ImageFastor(
        context: context!,
        width: 150,
        height: 150,
      radius_all: 75,
      assetAspectRatio: AssetImage("assets/images/logo.png"),
      urlAspectRation: UserSingleTone.instance().getImageUrl(),
    );
  }


  Widget username(){
    String name = UserSingleTone.instance().getUserName();
    if( ToolsValidation.isEmpty( name )) return SizedBox();
    return TextFastor( name,
        color: HexColor( ColorProject.black_1),
          fontFamily: FontProject.marina,
         fontSize: 20,
    );
  }

}