
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/setting/data/model/MSettingAdmin.dart';
import 'package:umq/modules/setting/presentation/admin/detail/c/ControllerSetting.dart';
import 'package:umq/modules/setting/presentation/admin/detail/v/views/ContentConferenceDetail.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';


class SettingDetailAdminPage extends StatefulWidget {




  @override
  SettingDetailAdminState createState() {
    return SettingDetailAdminState(  );
  }


}

class SettingDetailAdminState extends ResumableState<SettingDetailAdminPage > {

  //-------------------------------------------------------------------- variable


  String pageTitle = "Setting Admin" ;
  MSettingAdmin? mEdit  ;

  var progressStatus = false;

  //long description
  var aboutUsUrl = "";
  var termsUrl = "";

  //------------------------------------------------------------------- life cycle

  @override
  void initState() {
    super.initState();
    // download data
    WidgetsBinding.instance.addPostFrameCallback((_)async{
      Log.i( "setting detail - addPostFrameCallback() ");
      await startGetSettingAPI();
      // debugAutomator();
    });

  }


  @override
  void onReady() {
    super.onReady();
    onResume();
  }


  @override
  void onResume(){
    super.onResume();
    Log.i("conference detail - onResume()");

  }



  //-------------------------------------------------------------------- build

  BuildContext? contextPage;
   ProgressCircleState? prg;

  @override
  Widget build(BuildContext context) {
    this.contextPage = context;
    //Log.i("conference detail - build()");
    return getPageTemplate();
  }


  Widget getPageTemplate(){

    return PageTemplate.t(  this ,
        title: pageTitle,
        content: pageResponsive(),

        //toolbar
        toolbar: tooblar() ,
        toolbar_height:  AdminToolbar.toolbarHeightLayer,
        onChangeProgressState: (value) => prg = value
    );
  }


  Widget tooblar(){
    return AdminToolbar(
      contextPage: context,
      pageTitle: pageTitle,
      clickRefresh : (b){
        startGetSettingAPI();
      },

      createPageNameGoTo: null ,
      resume: this,

    );
  }


  Widget pageResponsive() {
    var content =  ResponsiveFourmMobile.wrapHeight(  contextPage!, getContent() );
    return content;
  }


  Widget getContent() {

    if( progressStatus ) {
      return ProgressSpinkit.centerPage(context);
    }


    return ColumnTemplate.t( children: [

      aboutUsHtmlWidget(),
      termsHtmlWidget(),
      bt_save()
    ],
    mainAxisAlignment: MainAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    crossAxisAlignment: CrossAxisAlignment.start
    );
  }


}