import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/notification/presentation/admin/detail/c/PickerListener.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/NotificationCreateAdminPage.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/views/ContentUserDetail.dart';


const double _spinnerWidth = 170; //AdminDSDimen.inputFiled_value_width;

extension SpinnerSelectTypeTopic on NotificationCreateAdminState {

  Widget spinner_topic() {
    var row =  RowTemplate.scroll(context,  [
      _tv_title(),
      _spinner()
    ]);

    var column = ColumnTemplate.t(  children: [
      row,
      showNamePicker()
    ]);

    return Container( child: column ,
      margin: EdgeInsets.only(top: DSDimen.space_level_2,
          left: DSDimen.space_level_2),
    );
  }

  Widget _tv_title(){
    return TextTemplate.t( "Target",
        width: AdminDSDimen.inputFiled_title_width,
        levelDS: LevelDS.l2);
  }

  Widget _spinner() {
    return Container(
      child:  _getSpinner(),
      decoration: BoarderHelper.box(),
      margin: EdgeInsets.only( top: DSDimen.space_level_2 ), //top 12 : fix underline not same aligment
    );
  }

  Widget _getSpinner(){
    var drop = SpinnerView(
        childers: _getListWidgetChild(),
        hintWidget: _getHint(),
        width_frame: _spinnerWidth,
        height_frame: 45,
        onSelectPosition: (p, isRemoveSelected) {

          _updateSelectedSpinner(p, isRemoveSelected );

        }, iconSize: 22,);
    return SizedBox( child:  drop,
      height: 40,
    );
  }

  void _updateSelectedSpinner( int position, bool isRemoveSelected){
    // Log.i("spinner_typeJob() -  position: " + position.toString()  );

    if (isRemoveSelected) {
      topicSelectedType = "";
      return;
    }

    //get by position
    String name  = _getListMode()[ position ];
    Log.i("spinner_typeJob() -  topicSelected: " + topicSelectedType);

    //now set type
    topicSelectedType = name;

    //check choose picker user
    if( name == "User" ) {
      pickerUserDialogOpen();
      return;
    }

    //check choose "all"
    if( name == "All" ) {
      userSelected = null;
      return;
    }

  }


  Widget _getHint() {
    return   TextTemplate.t(  "Select Target",
      levelDS: LevelDS.l2,
      color: DSColor.spinner_hint,
      gravityLayoutAlign: Alignment.centerLeft ,
      padding: EdgeInsets.only( left: 3.5 ),
      width: _spinnerWidth,
      height: 55,
    );
  }


  List<Widget> _getListWidgetChild() {
    List<Widget> listWidget = [];
    for ( String s in _getListMode() ) {
      listWidget.add( _getSingleWidgetByPosition(s) );
    }
    return listWidget;
  }


  Widget  _getSingleWidgetByPosition(String s ) {
    return   TextTemplate.t( s,
        levelDS: LevelDS.l2,
        gravityLayoutAlign: Alignment.centerLeft ,
        padding: EdgeInsets.only(top: 10, left: DSDimen.space_level_3),
        color: DSColor.ds_textfield_text,
        width: _spinnerWidth,
        height: 55
    );
  }


  List<String> _getListMode(){
    List<String>  listString = [];
    listString.add( "All" );
    listString.add( "User" );
    // listString.add( "Student" );
    // listString.add( "Provider");
    return listString;
  }


}