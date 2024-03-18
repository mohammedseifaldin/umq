import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/data/source/GetSettingAdminAPI.dart';
import 'package:umq/modules/setting/data/source/SettingAdminUpdateAPI.dart';
import 'package:umq/modules/setting/presentation/admin/detail/c/EditUserController.dart';
import 'package:umq/modules/setting/presentation/admin/detail/m/MapRequest.dart';
import 'package:umq/modules/setting/presentation/admin/detail/v/SettingDetailAdminPage.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/toolsUI/html/editior/HtmlEditiorPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension  ControllerSetting on SettingDetailAdminState {

  startGetSettingAPI() async {

    setState(() {
      progressStatus = true;
    });

    await GetSettingAdminAPI().getData((status, msg, response) {


      setState(() {
        progressStatus = false;
        mEdit = response;
        setEditDataIfFound();
      });

    });
  }
  //--------------------------------------------------------------------- save

  Future save_click() async {
    Log.i( "save_click() - ");

      //validate
    if( validate_save() == false ) return;
    Log.i( "save_click() - validate_save true");

    //choose type edit or create
    if( mEdit != null ) {
      await _apiCreate();
    }

  }

  bool validate_save(){

    //wait download setting
    if( mEdit == null ) {
      ToolsToast.i(context,  "Wait Download Setting");
      return false ;
    }

    //about us "optional"
    //terms us "optional"

    Log.i( "validate_save() - return - (true) " );
    return true;
  }

  //--------------------------------------------------------------------------- create new object

  Future _apiCreate() async {

    if(prg!= null )prg!.show();

    final request = mapTextFieldValuesToRequestAPI();
    await SettingAdminUpdateAPI().setData( request,  (code, msg) {

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

  //--------------------------------------------------------------- html

  Future openHtmlEditorAboutUs() async {

    final fileNameHtml = "about_us";

    var page = HtmlEditiorPage(uniqueName: fileNameHtml,
        edit_url_content: aboutUsUrl,
        callback: (String value) {
          aboutUsUrl = value;
    });
    NavigationTools.push(context, page);
  }


  Future openHtmlEditorTerms() async {

    final fileNameHtml = "terms_and_condition";

    var page = HtmlEditiorPage(uniqueName: fileNameHtml,
        edit_url_content: termsUrl,
        callback: (String value) {
          termsUrl = value;
        });
    NavigationTools.push(context, page);
  }




}