
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/tools/resourceProject/ResourceColorAdmin.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';

extension ExtenstionToolbarInfo on AdminToolbar {

  Widget barToolbarInfo() {
    //check mobile device
    if( DeviceTools.isPortrait( contextPage ) ) {
      return EmptyView.zero();
    }



    //show view
    var stackBarInfo =  Stack( children: [

      //size
      EmptyView.empty( DeviceTools.getWidth( contextPage ), AdminDSDimen.toolbarSimple_barInfo),

      rowControllePanel(),

      //under line
      Positioned( child:  underLine(), bottom: 0,)

    ]);
    return stackBarInfo;
  }


  //----------------------------------------------------------------- title

  Widget rowControllePanel() {
    return RowTemplate.wrapChildren( [
      title(),
      tx_controllePanel()
    ]);
  }


  Widget title(){
    return TextTemplate.t( pageTitle,
        margin: EdgeInsets.only(
            left: DSDimen.space_level_1,
            top: DSDimen.space_level_2),
        textAlign: TextAlign.center,
        color: ResourceColorAdmin.blueDark,
        levelDS: LevelDS.l1 );
  }


  Widget tx_controllePanel() {
    return TextTemplate.t( "Control Panel" ,
    margin: EdgeInsets.only(left: DSDimen.space_level_3),
    color: DSColor.ds_background_toolbar,
    levelDS: LevelDS.l2);
  }

  //--------------------------------------------------------------- styles

  Widget underLine() {
    var widthLine = DeviceTools.getWidth( contextPage ) - (DSDimen.space_level_1 *2);
    var line =  EmptyView.colored( widthLine,
        5,
     DSColor.ds_background_toolbar  //same color of controller panel text
    );

    return Container( child:  line,
      margin: EdgeInsets.only(left: DSDimen.space_level_1,
      right: DSDimen.space_level_1),
    );
  }


}