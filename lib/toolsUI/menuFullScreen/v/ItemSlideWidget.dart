import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/menuFullScreen/m/MItemSlide.dart';
import 'package:umq/toolsUI/menuFullScreen/v/MenuFullPageWidget.dart';


class ItemSlideWidget extends StatelessWidget {

  MItemSlide m;

  ItemSlideWidget(this.m);

  BuildContext? context;

  @override
  Widget build(BuildContext context) {
    this.context = context;

    //background
    var contBackground = Container( child:  button(),
      // color: MenuProjectState.colorBackground,
      // width: DeviceTools.getWidth(context),
      margin: EdgeInsets.only(bottom: DSDimen.space_level_4 ),
    );

    return contBackground;

  }


  Widget button() {
    var bt =  ButtonTemplate.t( m.title, () {
      Log.i( "click on item slide: " + m.title );
      NavigationTools.pushAndRemoveUntil(context!,  m.pageToOpen);
    },

      // padding: EdgeInsets.all( 5),
      width: 150,
      height: 40,
      levelDS: LevelDS.l2,
      textColor: HexColor( ColorProject.blue_fish_back ),
      background: DSColor.menu_selected,
    );

    return bt;
    // return SizedBox( child: bt , width: 100,);
  }


}

//click
// return GestureDetector( child:  contBackground ,
// onTap: (){
//   Log.i( "click on item slide: " + m.title );
//   NavigationTools.pushAndRemoveUntil(context,  m.pageToOpen);
// },
// );
//buton
// var contButton =  Container(
// width: 200,
//   margin: EdgeInsets.only(top: DSDimen.space_level_2),
//   padding: EdgeInsets.all( 30),
//   color: DSColor.menu_selected,
//   child: TextTemplate.t( m.title, levelDS: LevelDS.l3),
// );

