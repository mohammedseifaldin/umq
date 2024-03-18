

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/message/NewMessageSingleTone.dart';
import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class ToolbarChatHome extends StatefulWidget {

  static const double toolbarHome_height = 70;

  BuildContext contextPage;
  String myTitle;

  ToolbarChatHome( this.contextPage,  this.myTitle) ;


  @override
  ToolbarChatHomeState createState()  {
    return  ToolbarChatHomeState(myTitle  );
  }
}

class ToolbarChatHomeState extends  State<ToolbarChatHome>   {

  String myTitle;
  ToolbarChatHomeState(this.myTitle ) ;


  @override
  Widget build(BuildContext context) {
  //  return shadowCardViewCustomeRadius( getContentToolbar() );
    return getContentToolbar();
  }


  Widget getContentToolbar(){
    var con = Container(
      width: DeviceTools.getWidth(context),
        height: ToolbarChatHome.toolbarHome_height,
        alignment: Alignment.topLeft,
        color: ChatColor.ds_background_toolbar,
        child: stackAllContent(),
    );
    return con;
  }

  //------------------------------------------------------------------- card view

  Widget shadowCardViewCustomeRadius(Widget child) {

    //elevation
    var physical =   PhysicalModel(
      elevation: 20,
      color:  DSColor.cardview_shadow,
      child: child,
    );

    //custome radius
    var objRadius = Radius.circular( 15 );
    var radiusCustom = BorderRadius.only( bottomLeft: objRadius, bottomRight:  objRadius  );

    //clip to card shape
    return ClipRRect(
      borderRadius: radiusCustom,
      child: physical,
    );
  }

  //------------------------------------------------------------------------ child

  Widget stackAllContent() {
   return Stack( children: [


     //back icon
     Positioned(child:  backIm() , left: 0,  bottom: 0, top: 0,  ),
     // Positioned(child:  BackButtonChatView( widget.contextPage) , left: 0,  bottom: 0, top: 0,  ),

     //title
     Positioned(child:  title(), left: 0, right: 0 ),

     
   ]);
  }


  Widget title(){
    var txt =  TextTemplate.t( myTitle,
        textAlign: TextAlign.center,
        color: HexColor( ColorProject.white_sun_4 ),
      levelDS: LevelDS.parent,
      margin: EdgeInsets.only(top: DSDimen.space_level_1 )
    );
    return txt;
  }


  Widget backIm() {
    return ImageView(width:  45, height: 40,
    padding: EdgeInsets.all( 10 ),
      margin: EdgeInsets.only(left: DSDimen.space_level_1 ),
      onPressed: (){

        //stop socket
        NewMessageSingleTone.instance().stopSocket();

      // GoTo.chooseHomeByTypeRoleUser(context);

        GoTo.homeStudent( widget.contextPage);

      },
      assetAspectRatio: FastorDrawable.arrow_back_white,
    );
  }



}