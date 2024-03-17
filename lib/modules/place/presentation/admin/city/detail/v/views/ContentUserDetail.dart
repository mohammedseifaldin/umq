
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/c/ClickActionsUserDetails.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/c/EditController.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/v/CityDetailAdminPage.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/data/model/MCityTools.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ContentUserDetail on CityDetailAdminState {


  //---------------------------------------------------------------------- name

  Widget name_en() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_nameEn(),
      tf_nameEn()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_nameEn(){
    return TextTemplate.t( "name en",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_nameEn(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: getEditNameEn(),
        autovalidateMode: nameEn_valid,
        validatorCustom: ValidatorTemplate.name(  ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => nameEn_txt = value
    );
  }


  //---------------------------------------------------------------------- name_ar

  Widget name_ar() {
    var row =  RowTemplate.scroll(contextPage!,  [
      tv_nameAr(),
      tf_nameAr()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_nameAr(){
    return TextTemplate.t( "name ar",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_nameAr(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: getEditNameAr(),
        autovalidateMode: nameAr_valid,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.emailAddress,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => nameAr_txt = value
    );
  }

  //------------------------------------------------------------ save

  Widget save(){
    var bt = ButtonTemplate.t( "save", () {
      save_click();
    },
    margin: EdgeInsets.only(top: DSDimen.space_level_2 + 2 ,
    bottom: DSDimen.space_level_1 )
    );

    return Container( child: bt,
    alignment: Alignment.center,
    );
  }




}