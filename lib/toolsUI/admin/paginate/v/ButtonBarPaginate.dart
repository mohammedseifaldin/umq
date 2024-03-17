


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/container/ContainerTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/row/RowTemplate.dart';


import 'package:flutter/material.dart';
import 'package:umq/toolsUI/admin/paginate/c/ButtonNextPreviousController.dart';
import 'package:umq/toolsUI/admin/paginate/v/PaginateAdminWidget.dart';

extension ButtonBarPaginate on PaginateAdminState {


  Widget buttonBarPaginate() {
    return ContainerTemplate.wrapContent(
        _getRow()
        , align: Alignment.center,
      margin: EdgeInsets.only( left: DSDimen.space_level_2 )
    );
  }


  Widget _getRow(){
    return RowTemplate.wrapChildren_gravityCenter( [
        _btPrevious(),
      _rowNumbers(),
      _btNext()
    ]  );
  }

  //---------------------------------------------------------------------------- next and previouis

  Widget _btPrevious(){
    return ButtonTemplate.t( "Previous" , () {

      previousButtonFunction();
    } ,
        margin: EdgeInsets.only( right: DSDimen.space_level_4 ), //left: DSDimen.space_level_1,
    //    padding: EdgeInsets.symmetric( horizontal: DSDimen.space_level_3, vertical: DSDimen.space_level_4 ),
      //  textColor: Colors.black,
        levelDS: LevelDS.l2,
    // background: Colors.transparent,
    // borderRadius: DSDimen.ds_button_large_corner ,
    // borderLine: Colors.black
    );
  }


  Widget _btNext(){
    return ButtonTemplate.t( "Next" , () {
      nextButtonFunction();
    } ,
        // margin: EdgeInsets.only(right: DSDimen.space_level_1 ),
      //  padding: EdgeInsets.symmetric( horizontal: DSDimen.space_level_3, vertical: DSDimen.space_level_4 ),
    //    textColor: Colors.black,
        levelDS: LevelDS.l2,
        // background: Colors.transparent,
        // borderRadius: DSDimen.ds_button_large_corner ,
        // borderLine: Colors.black
    );
  }

  //---------------------------------------------------------------------------- rows numbers

  Widget _rowNumbers(){
    return RowTemplate.wrapChildren_gravityCenter(
        listNumberWidget
    );
  }

}