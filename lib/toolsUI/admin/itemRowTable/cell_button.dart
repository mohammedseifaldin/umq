

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:flutter/cupertino.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
// ignore: camel_case_types
class cell_button extends StatefulWidget {

  String text;
  double width_frame;
  VoidCallback onPressed;

  //
  double? height;

  cell_button(this.text, this.width_frame, this.onPressed, { this.height});

  @override
  cell_button_state createState() {
    // TODO: implement createState
    return cell_button_state(text, width_frame, onPressed);
  }

}


class cell_button_state extends State<cell_button> {


  String text;
  double width_frame;
  VoidCallback onPressed;

  cell_button_state(this.text, this.width_frame, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Stack( children: [
      box(),

      Positioned(child:  button() , top:  0 )
    ],);
  }


  Widget button() {

    return ButtonTemplate.t( text, () { onPressed(); } ,
        levelDS: LevelDS.l4,
        // padding: EdgeInsets.only(left: 5, right: 5),
        margin:  EdgeInsets.only(left: 5 ),
      // width: width_frame,
      // height: DSDimen.text_level_4 + 10,
        // background : DSColor.button_h2,
        // textColor: DSColor.table_row_title

      );

  }


  Widget box( ) {
    return   Container(
      width : width_frame,
      height: widget.height??AdminDSDimen.row_height_m,
      alignment: Alignment.centerLeft,
      decoration: BoarderHelper.rounded(
          radiusSize: 0,
          colorBackground: DSColor.table_row_background,
          colorLine: DSColor.table_row_boader
      ),
    );
  }


}