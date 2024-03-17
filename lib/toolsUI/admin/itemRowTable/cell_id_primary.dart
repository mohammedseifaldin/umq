import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class cell_id_primary extends StatefulWidget {

  int? value;
  double width;
  VoidCallback onPressed;
  double? height;

  cell_id_primary(this.value, this.width, this.onPressed, { this.height});

  @override
  cellIdPrimaryState createState() {
    // TODO: implement createState
    return cellIdPrimaryState( value, width, onPressed );
  }
}

class cellIdPrimaryState extends State<cell_id_primary> {

  int? value;
  double width;
  VoidCallback onPressed;

  cellIdPrimaryState(this.value, this.width, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Stack( children: [
      box(),
      txt(),
      Positioned(child:  buttonShow() , right: DSDimen.space_level_3, top:  0  )
    ],);
  }


  Widget txt() {
    return TextTemplate.t(   value.toString(),
      width:  width,
      levelDS: LevelDS.l3,
        padding: EdgeInsets.only(left: 5, top: 5),
    height: AdminDSDimen.row_height_m,
    gravityLayoutAlign: Alignment.topLeft,
       // color: ResourceColorAdmin.table_row_title
        color: DSColor.table_row_title
    );
  }


  Widget box( ) {
    return   Container(
      width : width,
      height: widget.height??AdminDSDimen.row_height_m,
      decoration: BoarderHelper.rounded(
          radiusSize: 0,
          // colorBackground: ResourceColorAdmin.table_row_background,
        colorBackground: DSColor.table_row_background,
          // colorLine: ResourceColorAdmin.table_row_line
          colorLine: DSColor.table_row_boader
      ),
    );
  }


  Widget buttonShow() {
    return ButtonTemplate.t( "show", () {
      onPressed();
    },
    levelDS: LevelDS.l4);
  }

}
