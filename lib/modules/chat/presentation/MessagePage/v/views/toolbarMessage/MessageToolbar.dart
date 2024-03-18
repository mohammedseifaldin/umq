import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/shared/ToolsUIChat/backButton/BackButtonChatView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatDrawable.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/navigate/GoTo.dart';

class MessageToolbar extends StatefulWidget {

  BuildContext pageContext;
  MUser? userTargetSmall;
  ValueChanged<MessageToolbarState> stateListener;
  static double height_Frame = 70.0;

  MessageToolbar( this.pageContext, this.userTargetSmall , this.stateListener);

  @override
  MessageToolbarState createState() {
    var state = MessageToolbarState();
    stateListener(state);
    return state;
  }

}

class MessageToolbarState extends State<MessageToolbar> {

  @override
  Widget build(BuildContext context) {
    return getCard();
  }

  void updateUserData(MUser m){
    setState( (){
    //  Log.i( "updateUserData() - m: " + m.toString() );
      widget.userTargetSmall = m;
    });
  }

  Widget getCard(){
    var cont =  Container( child: getContent(),
      color: ChatColor.ds_background_toolbar,
      width: DeviceTools.getWidth(context),
      height: MessageToolbar.height_Frame,
    );

    return BoarderHelper.cardViewPhysical(
        child:  cont ,
        elevation_radius_value: 15,
        radiusBorder: BorderRadiusTools.get(
            radius_bottomLeft: 15,
            radius_bottomRight:  15 )
    );
  }


  Widget getContent(){
    return Stack( children: [

      EmptyView.empty(DeviceTools.getWidth(context), MessageToolbar.height_Frame),

      //back
      Positioned(child: BackButtonChatView( widget.pageContext), top: 0, bottom: 0 , ),

      //photo
      photoIm(),

      //name
      Positioned(child:  nameTv(), top: 23 ,
        left: 45 + 50 +  DSDimen.space_level_3 ,)
    ]);
  }

  //---------------------------------------------------------------------- photo
  
  Widget photoIm(){

    var im =  ImageViewTemplate( context: context ,
      widthNeeded: 45,
      heightNeeded: 45,
      radius_all: 12.5,
        padding: EdgeInsets.all(5 ),
        // margin: EdgeInsets.only(left: DSDimen.space_level_2),
      // colorBackground: Colors.bl,
      assetAspectRatio: ChatDrawable.images( "person_white"),

      urlBackground:  getUserPhotoUrl(),
      boxFit_background: BoxFit.cover,

      onPressed: () {

        GoTo.fullScreenImage( context, getUserPhotoUrl() );
    },
    );

    //margin
    return Container( child: im,
      margin: EdgeInsets.only(
          left: 60 ,
        top: 10

      ),
    );
  }


  String getUserPhotoUrl() {
   // Log.i( "getUserPhotoUrl() - start: " + widget.userTargetSmall.toString() );
    if( widget.userTargetSmall == null ) return "";
    if( widget.userTargetSmall == null ) return "";


    var  user =  widget.userTargetSmall;
    if( user == null ) return "";
    if( user.photo == null ) return "";
   //Log.i( "getUserPhotoUrl() - photoUrl: " + photoUrl.toString() );
    return user.photo!;
  }

  //------------------------------------------------------------------- name

  Widget nameTv(){

    return TextTemplate.t( getUserName(),
      levelDS: LevelDS.l1_dark,
      // margin: EdgeInsets.only( left: DSDimen.space_level_3  )
    );
  }


  String  getUserName(){
    if( widget.userTargetSmall == null ) return "";
    return widget.userTargetSmall!.name!;
  }

  //------------------------------------------------------------------- back


}