
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/SubscribePackageListAdminPage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/widget/ExtenstionColum.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/widget/ExtenstionRow.dart';


import 'package:umq/toolsUI/toast/ToastTools.dart';

extension  MapModelToWidget on SubscribePackageListAdminPageState {


  void initRowWidgetTableAndSetHeaderData(){

    ///remove old data
    listRow = [];

    /// first add header
    Widget headerRow = columnHeader();
    var paddingHeader = Padding(
      padding: EdgeInsets.only(top: DSDimen.space_level_2 ),
      child: headerRow,
    );
    listRow.add(  paddingHeader );
  }


   mapResponseArrayToWidget()  {

    ///check download not completed
    if( provider!.responsePaginateSubscribePackage == null ) return;
    if( provider!.responsePaginateSubscribePackage!.data == null ) return;

    ///list data
    var dataList = provider!.responsePaginateSubscribePackage!.data!.data!;

    /// check empty
    if( dataList.isEmpty ) {
      ToolsToast.i( context,  "No Data Found" );
      return;
    }

    ///now loop to generate widget
    int positionAtTable = 1;
    for( var  m in  dataList  ) {
      Widget w  =   rowItemResult(m  );
      listRow.add( w );
      positionAtTable = positionAtTable + 1;
    }
 //   Log.i("mapResponseArrayToWidget() - listRow - len: " + listRow.length.toString() );

  }


}