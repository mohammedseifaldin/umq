
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/v/CityDetailAdminPage.dart';
import 'package:umq/modules/place/presentation/admin/city/list/c/SearchDownloadController.dart';
import 'package:umq/modules/place/presentation/admin/city/list/v/ExtenstionSearchFilterBar.dart';


import 'package:umq/toolsUI/admin/toolbar/AdminToolbar.dart';

import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';
import 'package:umq/modules/place/data/model/MCity.dart';


import 'package:umq/modules/place/data/response/ResponseListCity.dart';

import 'package:umq/tools/constant/EnvironmentConstant.dart';

class CityListAdminPage extends StatefulWidget {

  @override
  CityListAdminState createState() {
    return  CityListAdminState();
  }
}

class CityListAdminState extends ResumableState<CityListAdminPage > {

  //--------------------------------------------------------------- data and varaible

  //title
  String pageTitle = "Cities";

  //response and table
  late TableViewFastorState tbState;
  ResponseCityList response = ResponseCityList();
  List<MCity> listProjectFiltered = []; //the list of project after fliter done
  List<Widget> listRow = [];  //header + result

  //search text
  var search_txt = "";
  var search_controller = TextEditingController();

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
          if (mounted == false ){
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
        createPageNameGoTo: CityDetailAdminPage(),
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
    return ColumnTemplate.t( children: [
      barFilterAndSearchView(),
      table()
    ]);
  }

  //-------------------------------------------------------------------- table

  Widget table() {
    // var listView =  ListViewTemplate.t(children: listRow,
    //     axis: Axis.vertical, axisBoth: true);
    var tb = TableViewFastor( listRow , stateListener: (state) {
      tbState = state;
    });

    return Container( child:  tb,
      // padding: EdgeInsets.only(top : DSDimen.space_level_2 ),
      // margin: EdgeInsets.symmetric(horizontal: DSDimen.space_level_1 ),
    );
  }

}