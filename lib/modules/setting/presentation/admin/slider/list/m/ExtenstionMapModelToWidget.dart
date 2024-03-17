
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/ExtenstionColumSlider.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/ExtenstionRowSlider.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/SliderListAdminPage.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';


import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ExtenstionMapModelToWidget on SliderListAdminState {


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
    for( MSlider m in  dataList  ) {
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