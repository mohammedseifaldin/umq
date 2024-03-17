import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/tools/resourceProject/DrawableAdmin.dart';
import 'package:umq/toolsUI/admin/toolbar/ExtenstionToolbarInfo.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class AdminToolbar extends StatelessWidget {

  BuildContext contextPage;
  String pageTitle ;
  Widget? createPageNameGoTo;
  ResumableState? resume;

  // bool? hideCreateButton;

  static double toolbarHeightLayer = 60;


  ValueChanged<String> clickRefresh;

  AdminToolbar(
      {
        required this.contextPage,
        required this.pageTitle,
        required this.clickRefresh,
        this.createPageNameGoTo,
        // this.hideCreateButton,
        this.resume
  }){
    //increase height of toolbarMessage web
    if( DeviceTools.isLandscape( contextPage  ) ) {
      toolbarHeightLayer = 150;
    }
  }



  @override
  Widget build(BuildContext context) {

    return getToolbarLayers();
  }


  //------------------------------------------------------------------   toolbarMessage

  /**
      toolbarMessage have many layers :
      a- bar title : slide menu button
      b- bar info : for page in website
      c- bar search tools
   */
  Widget getToolbarLayers(){

    return Stack( children: [
      //color background
      EmptyView.colored( DeviceTools.getWidth(contextPage),
          toolbarHeightLayer, DSColor.ds_background_all_screen),
      columnToolbarBars()
    ],);
  }


  Widget columnToolbarBars() {
    var col =  Column( children: [
      ToolbarSimpleFastor(  contextPage,
          pageTitle,
          buttonLeft: bt_menu(),
          buttonRight: buttonRightRow() ,
          hideBackButton: true ),
      barToolbarInfo(),
    ]);

    return col;
  }

  //------------------------------------------------------------ button at toolbarMessage

  Widget bt_menu() {
    return ImageView(width: 18+20+10, height: 18+20+10,
      assetAspectRatio: DrawableProject.admin( "menu"),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(left: 20),
      onPressed: (){
        Log.i( "click on menu from tooblar");
        GoToAdmin.menuFullPage(contextPage);
      },
    );
  }


  double size_button_create = 18+20+10;

  Widget bt_create(){

    //check not  found
    if( createPageNameGoTo == null ) {
      return EmptyView.zero();
    }

    //button with click
    return ImageView(width: size_button_create, height:  size_button_create,
      assetAspectRatio: DrawableProject.admin( "plus_circle"),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20),
      onPressed: (){
        Log.i( "click on create from tooblar");
        NavigationTools.pushResume(contextPage,  createPageNameGoTo!, resume!);
      },
    );
  }

  Widget buttonRightRow() {
    return RowTemplate.wrapChildren_gravityCenter (  [
      bt_refresh(),
      bt_create()
    ]
    );
  }


  Widget bt_refresh(){
    return ImageViewTemplate(context: contextPage,
        widthNeeded: size_button_create  , //why 0.80 %  i see as my eye it's too big
        heightNeeded: size_button_create * 1.07  ,
      assetAspectRatio: DrawableAdmin.image( "refresh_circle"),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 20),
      onPressed: (){
        Log.i( "bt_refresh() click ");
        clickRefresh( "");
      },
    );
  }

}