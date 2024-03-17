
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
import 'package:flutter/cupertino.dart';
import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';

// ignore: camel_case_types
class cell_detail_short extends StatelessWidget {

  String? value;
  double width;
  double? height;

  cell_detail_short(this.value, this.width, { this.height});


  @override
  Widget build(BuildContext context) {
    return Stack( children: [
      box(),
      txt()
    ],);
  }


  Widget txt() {
    return TextTemplate.t(   value.toString(),
      width:  width,
      levelDS: LevelDS.l3,
        padding: EdgeInsets.only(left: 5, top: 5),
    height: height??AdminDSDimen.row_height_m,
    gravityLayoutAlign: Alignment.topLeft,
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