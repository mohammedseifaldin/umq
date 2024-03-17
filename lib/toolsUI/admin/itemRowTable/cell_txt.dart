import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class cell_text extends StatefulWidget {

  String? value;
  double width;
  double? height;

  cell_text(this.value, this.width, { this.height});


  @override
  cell_textState createState() {
    // TODO: implement createState
    return cell_textState( value, width);
  }
}

class cell_textState extends State<cell_text> {

  String? value;
  double width;

  cell_textState(this.value, this.width);


  @override
  Widget build(BuildContext context) {

    return Stack( children: [
      box(),
     txt()
      // selectedTextWidget()
    ],);
  }




  Widget txt() {

    value ??= "NA";

    return TextTemplate.t(   value.toString(),
      width:  width,
      levelDS: LevelDS.l3,
        padding: EdgeInsets.all(5),
    height: widget.height??AdminDSDimen.row_height_m,
    gravityLayoutAlign: Alignment.topLeft,
        color: DSColor.table_row_title
    );
  }


  Widget box( ) {
    return   Container(
      width : width,
      height: widget.height??AdminDSDimen.row_height_m,
      // padding: EdgeInsets.all(10),
      decoration: BoarderHelper.rounded(
          radiusSize: 0,
          colorBackground: DSColor.table_row_background,
          colorLine: DSColor.table_row_boader
      ),
    );
  }


}