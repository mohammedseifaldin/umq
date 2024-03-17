
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
 
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/notification/presentation/admin/detail/c/ClickActionsUserDetails.dart';
import 'package:umq/modules/notification/presentation/admin/detail/c/PickerListener.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/NotificationCreateAdminPage.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ContentUserDetail on NotificationCreateAdminState {

  //-------------------------------------------------------------------- picker

  Widget showNamePicker(){

    //check not selected user
    if( userSelected == null ) {
      return EmptyView.zero();
    }

    return TextTemplate.t( userSelected!.name! ,
        margin: EdgeInsets.only(
            top: DSDimen.space_level_3,
          left: AdminDSDimen.inputFiled_title_width

        ),

        onPressed: () async {
          await pickerUserDialogOpen();
        },
        levelDS: LevelDS.l3 );
  }

  //---------------------------------------------------------------------- title

  Widget title() {
    var row =  RowTemplate.scroll(context,  [
      tv_title(),
      tf_title()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_title(){
    return TextTemplate.t( "Title",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_title(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        // hint_text: getEditNameEn(),
        autovalidateMode: title_valid,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.name,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => title_txt = value
    );
  }


  //---------------------------------------------------------------------- message

  Widget message() {
    var row =  RowTemplate.scroll(context,  [
      tv_message(),
      tf_message()
    ]);

    return Container( child: row ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }


  Widget tv_message(){
    return TextTemplate.t( "Message",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }


  Widget tf_message(){
    return TextFieldFastor(
        width: AdminDSDimen.inputFiled_value_width,
        // hint_text: getEditNameAr(),

        minLines: 4,
        autovalidateMode: message_valid,
        validatorCustom: ValidatorTemplate.name( ),
        keyboardType: TextInputType.emailAddress,
        decoration: BoarderHelper.box(),
        padding: EdgeInsets.all( DSDimen.textfield_auto_padding),
        onChanged: (value) => message_txt = value
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