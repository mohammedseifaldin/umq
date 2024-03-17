import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:flutter/material.dart';
import 'package:umq/tools/language/TranslateLangauge.dart';

import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

import '../WalkThroughPage.dart';

extension FirstBoarder on WalkThroughPageState {


  Widget firstBoarder() {

    return Stack(
      children: [
        im_boarder(),
        card_boarder()
      ],
    );
  }

//---------------------------------------------------------------------- image

  Widget im_boarder() {
    return ImageView(width: DeviceTools.getWidth(context), height: 275 ,
      assetBackground: DrawableProject.boarder_1,
    );
  }

  //---------------------------------------------------------------------- card

  Widget card_boarder() {
    var card =  CardViewTemplate.t(child: cardContent(),
        radius_all: 25,
        //  colorBoarderLine: Colors.red,
        width: DeviceTools.getWidth( context),
        height: 180 );

    //margin
    return Container( child:  card,
      margin: EdgeInsets.only(left: DSDimen.space_level_2,
          right: DSDimen.space_level_2,
          top: 200 ),
    );
  }


  Widget cardContent() {
    return ColumnTemplate.t(
        padding: EdgeInsets.all( DSDimen.space_level_2),
        children: [
          tv_scubaWorld(),
          tv_detal()
        ],
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        alignGravity: Alignment.topCenter);
  }


  Widget tv_scubaWorld() {
    return TextTemplate.t( TranslateLanguage.lang( "appName") ,

        color: HexColor( ColorProject.blueCerulean_1 ),
        levelDS: LevelDS.l1);
  }


  Widget tv_detal(){
    return TextTemplate.t( TranslateLanguage.lang( "scuba_splash_message_1" ) ,
      levelDS: LevelDS.l2,
      textAlign: TextAlign.center,
      margin: EdgeInsets.only(top: DSDimen.space_level_3 ),);
  }



}