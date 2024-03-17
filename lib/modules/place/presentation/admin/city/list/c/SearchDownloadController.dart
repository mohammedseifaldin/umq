

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/place/presentation/admin/city/list/m/ExtenstionMapModelToWidget.dart';
import 'package:umq/modules/place/presentation/admin/city/list/v/CityListAdminPage.dart';

import 'package:umq/tools/constant/AdminPanelConstant.dart';
import 'package:umq/modules/place/data/source/CityListAPI.dart';
import 'package:umq/tools/values/ToolsValue.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';


extension SearchDownloadController on CityListAdminState {

  //---------------------------------------------------------------------- buttons search

  Future searchTextClick() async {
    //search validate
    if( ToolsValue.isEmpty( search_txt) ) {
      ToolsToast.i(context,  "Missed Field");
      return ;
    }

    //refresh
    refreshFunction(isResetPage: true );
  }

  //---------------------------------------------------------------------- api types

  Future refreshFunction({required bool isResetPage}) async {
    // reset paginate
    if( isResetPage ) {
      page = 1;
      if(paginateState != null )paginateState!.resetPage();
    }

    //hide keyboard
    FocusScope.of( context).unfocus();

    //progress
    if(progressState != null ) progressState!.show();

    //listener
   await _listenerDownloadData();
  }


  Future _listenerDownloadData() async {

    //remove old data
    _removePreviousData();

    //listener
   await CityListAPI().getDataPaginate(page,    (   status ,  msg,   response   ) {
      this.response = response;


      //remove text
      search_txt = "";
      search_controller.text = "";

      //check status
      if( status == false ) {

        if(progressState != null ) progressState!.dismiss(  error: msg);

        //refresh to remove the previous data
        tbState.updateList( []);
        return false ;
      }

      //progress
      if(progressState != null ){
        progressState!.dismiss( dismissComplete: (b){
          //what to do every sometime after api response change to avoid bug slow progress
          updateTableData();
        });
      } else {
        updateTableData();
      }

      //update counter
      Log.i( "_listenerDownloadData() - update counter "  );
      if(paginateState != null ){
        paginateState!.setPaginateByRecordTotal(
            response.data!.total  ?? 0,
            AdminPanelConstant.perPage,
            response.data!.currentPage ?? page
        );
      }


    });
  }


  Future updateTableData() async {
    // now map data filtered to the view
    mapModelToWidget();
  }

  /**
   * to fix appened the new data above the previous data,
   * also fix when dataTable changes.
   *
   * Must call this method before change data of table
   */
  Future<void> _removePreviousData() async {
    listRow = [];
    listProjectFiltered = [];

    tbState.updateList( []);

    return ;
  }

}