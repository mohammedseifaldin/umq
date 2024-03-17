import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';
import 'package:flutter/cupertino.dart';

// ignore: camel_case_types
class cell_image_array extends StatelessWidget {

  List<dynamic>  list = [];
  double width;
  double? height;

  cell_image_array(this.list, this.width, { this.height});


  @override
  Widget build(BuildContext context) {
    return Stack( children: [
      box(),
      txt()
    ],);
  }



  Widget txt() {

    var numberOfImage = list.length.toString();
    String name = "Images: " + numberOfImage;

    return TextTemplate.t(  name,
        width:  width,
        levelDS: LevelDS.l3,
        padding: EdgeInsets.only(left: 5, top: 5),
        height: AdminDSDimen.row_height_m,
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