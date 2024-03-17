import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';

import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';

class FavoritePage extends StatefulWidget {

  @override
  FavoritePageState createState() {
    return FavoritePageState();
  }

}

class FavoritePageState extends ResumableState<FavoritePage> {

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t( this ,
        content: getContent(),

        //fixed background
        widgetBackground: BackgroundCardPage( toolbarHeight: ToolbarHomeScuba.frameHeight ),

    //toolbar
    toolbar: ToolbarHomeScuba( context , title: "Favorite" ),
    toolbar_height: ToolbarHomeScuba.frameHeight   ,

    //navigation
    navigationBottom: NavigationBarButtonsScuba( context, EnumNavigationPage.favorite ),
    navigationBottom_height: NavigationBarButtonsScuba.frame_height ,
    );
  }


  Widget getContent(){
    return ColumnTemplate.t( children : [
      Text("Favorite coming Soon, edition: " +  EnvironmentConstant.version.toString() ),
    ]);
  }

}