
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';


import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';




// ignore: camel_case_types
class cell_bool extends StatelessWidget {

  bool? value;
  double width;

  double? height;

  cell_bool(this.value, this.width, { this.height});



  @override
  Widget build(BuildContext context) {
    return Stack( children: [
      box(),
      txt()
    ],);
  }


  Widget txt() {

    value ??= false;

    var nameStatus = value!? "Yes" : "No";

    return TextTemplate.t(   nameStatus,
      width:  width,
      levelDS: LevelDS.l3,
        padding: EdgeInsets.only(left: 5),
    height: AdminDSDimen.row_height_m,
    gravityLayoutAlign: Alignment.centerLeft,
      color: DSColor.table_row_title
    );
  }


  Widget box( ) {
    return   Container(
      width : width,
      height: height??AdminDSDimen.row_height_m,
      decoration: BoarderHelper.rounded(
          radiusSize: 0,
          colorBackground: DSColor.table_row_background,
          colorLine: DSColor.table_row_boader
      ),
    );
  }


}