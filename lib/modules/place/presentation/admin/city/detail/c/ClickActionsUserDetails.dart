import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/m/CityCreateAPI.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/m/CityUpdateAPI.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/v/CityDetailAdminPage.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
//import 'package:umq/toolsUI/toast/ToastTools.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ClickActionsUserDetails on CityDetailAdminState {

  //--------------------------------------------------------------------- save

  Future save_click() async {

    FocusScope.of( contextPage!).unfocus();

    //validate
    if( validate_save() == false ) return;

    //choose type edit or create
    if( mEdit != null ) {
      await _editPreviousAPI();
    } else {
      await _apiCreate();
    }

  }

  bool validate_save(){

    //name en
    if( ToolsValidation.isName(nameEn_txt) == false ) {
      ToolsToast.i(contextPage!,  "Name En Missed");
      setState(() {
        nameEn_valid = AutovalidateMode.always;
      });
      return false;
    }

    //name ar
    if( ToolsValidation.isName(nameAr_txt) == false ) {
      ToolsToast.i(contextPage!,  "Name Ar Missed");
      setState(() {
        nameAr_valid = AutovalidateMode.always;
      });
      return false;
    }

    return true;
  }

  //--------------------------------------------------------------------------- create new object

  Future _apiCreate() async {

    if(prg!= null )prg!.show();

    //get data
    await CityCreateAPI().getData(nameEn_txt, nameAr_txt, (code, msg) {

          if(prg!= null )prg!.dismiss();

          //check failed
          if( ToolsAPI.isFailed( code )  ) {
            ToolsToast.i(contextPage!, msg );
            return;
          }

          //success
          ToolsToast.i(contextPage!,  msg );

          ToolsWait.waitToDo(300, ()  {

            //finish curent page
            Navigator.pop(contextPage!);

          });
        });
  }

  //---------------------------------------------------------------------- edit old object

  Future _editPreviousAPI() async {

    if(prg!= null )prg!.show();

    //listener
    int target_user_id = mEdit!.id!;
    await CityUpdateAPI().getData(target_user_id, nameEn_txt, nameAr_txt,
         (code, msg) {

          if(prg!= null )prg!.dismiss();

          //check failed
          if( ToolsAPI.isFailed( code )  ) {
            ToolsToast.i(contextPage!, msg );
            return;
          }

          //success
          ToolsToast.i(contextPage!,  msg );

          ToolsWait.waitToDo(300, ()  {

            //finish curent page
            Navigator.pop(contextPage!);

          });
        });
  }



}