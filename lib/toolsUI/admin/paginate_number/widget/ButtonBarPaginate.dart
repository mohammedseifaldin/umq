


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/container/ContainerTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/row/RowTemplate.dart';
import 'package:umq/toolsUI/admin/paginate_number/logic/ButtonNextPreviousController.dart';
import 'package:umq/toolsUI/admin/paginate_number/PaginateNumberWidget.dart';
import 'package:flutter/material.dart';

extension ButtonBarPaginate on PaginateNumberState {


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
        levelDS: LevelDS.l2,
    );
  }


  Widget _btNext(){
    return ButtonTemplate.t( "Next" , () {
      nextButtonFunction();
    } ,
        levelDS: LevelDS.l2,
    );
  }

  //---------------------------------------------------------------------------- rows numbers

  Widget _rowNumbers(){
    return RowTemplate.wrapChildren_gravityCenter(
        listNumberWidget
    );
  }

}