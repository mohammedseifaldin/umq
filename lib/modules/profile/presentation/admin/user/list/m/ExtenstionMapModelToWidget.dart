
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/ExtenstionColumUser.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/ExtenstionRowUser.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ExtenstionMapModelToWidget on UserListAdminState {


  Future mapModelToWidget() async {


    //list data
    var dataList = response.dataLaravel!.dataUsers!;

    //check there is result after filter complete
    bool isNoResultFound =  dataList.length == 0 ;
    if( isNoResultFound ) {
      ToolsToast.i( context,  "No Data Found" );
      // now print
      tbState?.updateList( []);
      return;
    }

    // //first add header
    Widget headerRow = columnHeader();
    listRow.add(  headerRow );

    //now loop to generate widget
    int positionAtTable = 1;
    for( MUser m in  dataList  ) {
      Widget w  = await rowItemResult(m  );
      listRow.add( w );
      //sleep( Duration( milliseconds: 10) );
      positionAtTable = positionAtTable + 1;
    }

    tbState?.updateList( listRow);

    // // now print
    // setState(() {
    // });
  }



}