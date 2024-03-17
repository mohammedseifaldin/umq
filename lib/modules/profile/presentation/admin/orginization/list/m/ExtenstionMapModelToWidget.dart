
import 'package:flutter/material.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/v/ExtenstionColum.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/v/ExtenstionRow.dart';


import 'package:umq/modules/profile/presentation/admin/orginization/list/v/OrgListAdminPage.dart';

import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';

import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ExtenstionMapModelToWidget on OrgListAdminState {


  Future mapModelToWidget() async {


    //list data
    var dataList = response.data!.data!;

    //check there is result after filter complete
    bool isNoResultFound =  dataList.length == 0 ;
    if( isNoResultFound ) {
      ToolsToast.i( context,  "No Data Found" );
      // now print
      tbState.updateList( []);
      return;
    }

    // //first add header
    Widget headerRow = columnHeader();
    listRow.add(  headerRow );

    //now loop to generate widget
    int positionAtTable = 1;
    for( MOrganization m in  dataList  ) {
      Widget w  = await rowItemResult(m  );
      listRow.add( w );
      //sleep( Duration( milliseconds: 10) );
      positionAtTable = positionAtTable + 1;
    }

    tbState.updateList( listRow);

    // // now print
    // setState(() {
    // });
  }



}