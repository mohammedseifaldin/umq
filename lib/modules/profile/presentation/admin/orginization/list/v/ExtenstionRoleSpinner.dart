
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';



// import 'package:fastor_app_ui_widget/resource/template/select/SpinnerTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';

import 'package:flutter/material.dart';
import 'package:umq/modules/place/presentation/admin/city/list/c/SearchDownloadController.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/c/SearchDownloadController.dart';


import 'OrgListAdminPage.dart';

const double _spinnerWidth = 100;

@Deprecated( "not used until today")
extension ExtenstionRoleSpinner  on OrgListAdminState {


  Widget spinner_role() {
    return Container(
      child:  _getSpinner(),
      decoration: BoarderHelper.box(),
      margin: EdgeInsets.only( top: 0), //top 12 : fix underline not same aligment
    );
  }

  Widget _getSpinner(){
    var drop = SpinnerTemplate(
        childers: _getListWidgetChild(),
        hintWidget: _getHint(),
        width_frame: _spinnerWidth,
        height_frame: 45,
        onSelectPosition: (p, isRemoveSelected) {

          _updateSelectedSpinner(p, isRemoveSelected );

        });
    return SizedBox( child:  drop,
    height: 40,
    );
  }

  void _updateSelectedSpinner( int position, bool isRemoveSelected){
    // Log.i("spinner_typeJob() -  position: " + position.toString()  );

    if (isRemoveSelected) {
      selectedRole = "";
      return;
    }

    //get by position
    selectedRole = _getListMode()[ position ];
    Log.i("spinner_typeJob() -  selectedRole: " + selectedRole);

    //refresh now
    refreshFunction(isResetPage: true );
  }


  Widget _getHint() {
    return   TextTemplate.t(  "Select Role",
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
        width: _spinnerWidth,
        height: 55
       );
  }


  List<String> _getListMode(){
    List<String>  listString = [];
    listString.add( "All" );
    listString.add( "Student" );
    listString.add( "Provider");
    return listString;
  }


}
