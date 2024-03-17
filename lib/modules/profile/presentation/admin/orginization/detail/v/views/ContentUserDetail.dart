
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/c/ClickActionsUserDetails.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/c/EditController.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/v/OrgDetailAdminPage.dart';


import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';


extension ContentUserDetail on OrgDetailAdminState {


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
    return TextTemplate.t( "name",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_nameEn(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        hint_text: getEditNameEn(),
        autovalidateMode: nameEn_valid,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => nameEn_txt = value
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