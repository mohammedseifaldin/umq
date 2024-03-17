
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/v/SliderDetailAdminPage.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/c/SearchDownloadController.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/m/list/ResponseSliderList.dart';

import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';
import 'package:umq/toolsUI/admin/toolbar/ExtenstionToolbarInfo.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';

import 'package:umq/modules/profile/data/model/m_user.dart';

import 'package:umq/tools/resourceProject/DrawableProject.dart';

import 'package:umq/tools/constant/EnvironmentConstant.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class SliderListAdminPage extends StatefulWidget {

  @override
  SliderListAdminState createState() {
    return  SliderListAdminState();
  }
}

class SliderListAdminState extends ResumableState<SliderListAdminPage > {


  //--------------------------------------------------------------- data and varaible

  //title
  String pageTitle = "Image Ads";

  //response and table
  late TableViewFastorState tbState;
  ResponseSliderList response = ResponseSliderList();
  List<MUser> listProjectFiltered = []; //the list of project after fliter done
  List<Widget> listRow = [];  //header + result

  //paginate
  PaginateAdminState? paginateState;
  int page = 1;

  //spinner
  String selectedRole = "";

  //--------------------------------------------------------------- life cycle

  @override
  void onReady() {
    super.onReady();
    onResume();
  }

  @override
  void onResume(){
    super.onResume();
    Log.i( "lifecycle - onResume - userListPage");
    debugMode();

    /**
        must to refresh the page after edit the record of table
     */
    refreshFunction(isResetPage: false );
  }

  //--------------------------------------------------------------- debug mode

  void debugMode(){
    if( EnvironmentConstant.isLive ) return;
    // search_controller.text = "abdo";
    // search_txt = "abdo";
  }

  //--------------------------------------------------------------- build

  ProgressCircleState? progressState;
  // var progressState = false;

  @override
  Widget build(BuildContext context) {
    // Log.i( "lifecycle - build()");

    return PageTemplate.t( this,
        title: pageTitle ,

        //toolbarMessage
        toolbar: tooblar() ,
        toolbar_height:  AdminToolbar.toolbarHeightLayer,

        //navigate
        navigationBottom: getPaginateBar(),
        navigationBottom_height: PaginateAdminWidget.getHeightFrame( context),

        content: pageContent(),
        onChangeProgressState: (s){

      //check lifey cycle not appera
          if (mounted == false ){
            Log.i("life cycle - mounted: " + mounted.toString() );
            return;
          }
          progressState = s;
    }
    );
  }

  //------------------------------------------------------------------ tooblar

  Widget tooblar(){
    return AdminToolbar(
        contextPage: context,
        pageTitle: pageTitle,
      clickRefresh : (b){
        refreshFunction(isResetPage: true );
      },

        createPageNameGoTo: SlideDetailAdminPage(),
      resume: this,

    );
  }

  //----------------------------------------------------------------- navigate

  Widget getPaginateBar(){
    var paginateWidget =  PaginateAdminWidget((page){
      pageChangeTo(page);
    }, stateListener: (state){
      paginateState = state;
    },
      //maxPage : 1000,
    );
    return paginateWidget;
  }


  void pageChangeTo(int updatePage ){
    Log.i("pageChangeTo() - updatePage: " + updatePage.toString() );
    page = updatePage;
    refreshFunction(isResetPage: false );
  }

  //----------------------------------------------------------------- content

  Widget pageContent() {
    // return ;
    var colum =  ColumnTemplate.t( children: [
    //  barFilterAndSearchView(),
      table()
    ]);

    // return Stack( children: [
    //   colum,
    //   progressCenter()
    // ]);
    return colum;
  }

  Widget progressCenter(){
    if( progressState == false ) {
      return EmptyView.zero();
    }

    return ProgressSpinkit.centerPage(context);
  }

  //-------------------------------------------------------------------- table

  Widget table() {
    // var listView =  ListViewTemplate.t(children: listRow,
    //     axis: Axis.vertical, axisBoth: true);
    var tb = TableViewFastor( listRow , stateListener: (state) {
      tbState = state;
    });

    return Container( child:  tb,
      padding: EdgeInsets.only(top : DSDimen.space_level_2 ),
      // margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_1 ),
    );
  }

}