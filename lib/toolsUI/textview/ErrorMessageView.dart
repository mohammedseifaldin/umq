import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class ErrorMessageView extends StatelessWidget {

  String msg;

  ErrorMessageView( this.msg );


  @override
  Widget build(BuildContext context) {
    return TextTemplate.t( msg,
    levelDS: LevelDS.l2,
    padding: EdgeInsets.all( DSDimen.space_level_2 ),
    color: HexColor( ColorProject.red )
    );
  }


}