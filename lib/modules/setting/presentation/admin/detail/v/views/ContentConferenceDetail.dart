


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/presentation/admin/detail/c/ControllerSetting.dart';


import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

import '../SettingDetailAdminPage.dart';

extension ContentUserDetail on SettingDetailAdminState {


  //------------------------------------------------------------ about us

  Widget aboutUsHtmlWidget() {
    var row = RowTemplate.scroll(context,    [
      tv_aboutUsDescription(),
      button_aboutUsDescription()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }

  Widget button_aboutUsDescription () {
    return  ButtonFastor( "write", () async {
      await openHtmlEditorAboutUs();
    },
      levelDS: LevelDS.l3_dark,
      width: 100,
      // height: 25,
    );
  }

  Widget tv_aboutUsDescription(){
    return TextTemplate.t( "About US",
        width: AdminDSDimen.inputFiled_title_width * 2,
        levelDS: LevelDS.l2);
  }



  //------------------------------------------------------------ terms

  Widget termsHtmlWidget() {
    var row = RowTemplate.scroll(context,    [
      tv_termsDescription(),
      button_termsDescription()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }

  Widget button_termsDescription () {
    return  ButtonFastor( "write", () async {
      await openHtmlEditorAboutUs();
    },
      levelDS: LevelDS.l3_dark,
      width: 100,
      // height: 25,
    );
  }

  Widget tv_termsDescription(){
    return TextTemplate.t( "Terms",
        width: AdminDSDimen.inputFiled_title_width * 2,
        levelDS: LevelDS.l2);
  }



  Widget bt_save() {
    return ButtonFastor(  "save",
      margin: EdgeInsets.symmetric(vertical: DSDimen.space_parent * 2 ),
      gravityLayout: Alignment.center,
      textColor: HexColor(ColorProject.white_sun_4),
      background: HexColor(ColorProject.black_1),
      height: 50,
      textFontSize: DSDimen.text_level_1,
          () async {
        await save_click();
      },
      // width: 300
    );
  }


}