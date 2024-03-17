

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';

import 'package:umq/modules/dashboard/data/response/ResponseAdminDashboard.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/logic/DashboardController.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/v/analtyicsCounter/CounterAnalyticsWidget.dart';

import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';
import 'package:umq/tools/fcm/abdo/FCMRegister.dart';

import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class DashboardPage extends StatefulWidget {

  @override
  DashboardState createState() {
    return DashboardState();
  }
}

class DashboardState extends ResumableState<DashboardPage> {

  var pageTitle = "Dashboard";
  var progressStatus = false;
  ResponseAdminDashboard? response;


  //-------------------------------------------------------------- life cycle

  @override
  void initState()    {
    super.initState();
    //  Log.i( "SplashScreenState - initState()");

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await startApiGetCounters();
      await setupFcmFromMainPage(context);
    });


  }

  //-------------------------------------------------------------- build page

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t( this,
        title: pageTitle,
        content: pageResponsive(),
      //toolbar
      toolbar: tooblar() ,
      toolbar_height:  AdminToolbar.toolbarHeightLayer,

    );
  }


  Widget pageResponsive() {
    var content =  ResponsiveFourmMobile.wrapHeight(  context, getContent() );
    return content;
  }


  Widget tooblar(){
    return AdminToolbar(
      contextPage: context,
      pageTitle: pageTitle,
      clickRefresh : (b){
         startApiGetCounters();
      },

      createPageNameGoTo: null ,
      resume: this,

    );
  }


  Widget getContent() {

    if( progressStatus ) {
      return ProgressSpinkit.centerPage(context);
    }

    return ColumnTemplate.t(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          counterAnalyticsWidget()

      ],
    );
  }


}