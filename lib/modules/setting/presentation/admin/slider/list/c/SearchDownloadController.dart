

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/m/ExtenstionMapModelToWidget.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/m/list/UsersListAPI.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/SliderListAdminPage.dart';
import 'package:umq/tools/constant/AdminPanelConstant.dart';


extension SearchDownloadController on SliderListAdminState {

  //---------------------------------------------------------------------- api types

  Future refreshFunction({required bool isResetPage}) async {

    //check mounted
    if( mounted == false ) {
      Log.i( "admin user list class - SearchDownloadController() - mounted stop !");
      return;
    }

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
   await SlideListAPI().getData(page,    (   status ,  msg,   response   ) {
      this.response = response;


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