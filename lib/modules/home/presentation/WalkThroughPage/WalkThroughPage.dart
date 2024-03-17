

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/home/presentation/WalkThroughPage/v/FirstBoarder.dart';
import 'package:umq/modules/home/presentation/WalkThroughPage/v/SecondBoarder.dart';
import 'package:umq/tools/navigate/GoTo.dart';



import 'package:umq/tools/resourceProject/ColorProject.dart';
// import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/cache/constant_save.dart';
import 'package:umq/tools/time/TimeTools.dart';
// import 'package:umq/toolsUI/PageViewFastor/PageViewFastor.dart';

class WalkThroughPage extends StatefulWidget {

  @override
  WalkThroughPageState createState() {

    return WalkThroughPageState();
  }
}

class WalkThroughPageState extends ResumableState<WalkThroughPage> {


  //--------------------------------------------------------------------- socket fcm

  Map<Object, Object>? socketFCMContent;

  void initSocketFCM() {
    if (context == null  )return;
    // ListenerToAndroidSocketFCM.setupCallBack(context, this , (isSocketDataFound, socket){
    //   Log.i( "WalkThroughPage - setupCallBack() - result: " +  socket.toString()  );
    //
    // });
  }

  //---------------------------------------------------------------------- life style

  @override
  void onReady() {
    super.onReady();
    Log.i( "WalkThroughPage - onReady()");
    onResume();
  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();
    initSocketFCM();
  }

  //---------------------------------------------------------------------- build stack

  @override
  Widget build(BuildContext context) {
    // this.context = context;
    Log.i( "WalkThroughPage() - isArabic: ${LanguageTools.isArabic( context)}") ;

   return PageTemplate.t( this,
       title: "appName",
       // assetBackground: DrawableProject.ui_s1,
       // assetBackgroundOpacity: 0.2,
       // toolbarHome: EmptyView.colored(20, 20, Colors.red ),
       // toolbar_height: 20,
       content:   getContent() ,
     statusBarColorCustom: HexColor( ColorProject.blueCerulean_3 )
   );
  }


  Widget getContent() {
   return  Stack(
     children: [

       Align( alignment: Alignment.topCenter, child:  pageView() ),

        Align( alignment: Alignment.center, child:  bt_next(),)

     ],
   );
  }

  //---------------------------------------------------------------------- pageView

  Widget pageView(){
    return PageViewFastor(
      width: DeviceTools.getWidth(context),
      height: 400,
      colorIndicatorOff: HexColor(ColorProject.blue_fish_front),
      colorIndicatorOn: HexColor(ColorProject.blue_fish_back),
      children: [
        firstBoarder(),
        secondBoarder()
        //test only
        // TextTemplate.t("1", color: Colors.blue, width: 200, backgroundColor: Colors.green),
        // TextTemplate.t("2", color: Colors.blue, width: 200),
        // TextTemplate.t("3", color: Colors.blue, width: 200)

      ],
      onChangePage: (p){
        Log.i( "change p : $p" );
      },);
  }

  //---------------------------------------------------------------------- bt_next

  Widget bt_next(){
    return ButtonTemplate.t( "Next" , (){

      Save.setString( ConstantSave.firstTimeOpenApp,   TimeTools.getCurrentTimestamp().toString() );

      GoTo.splashLogin( context );
    },
        width: 180, height: 40,
        //   borderRadius: 20,
        margin: EdgeInsets.only(top: 450)
    );
  }



}