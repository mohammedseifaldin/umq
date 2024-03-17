import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/template/emptyView/EmptyView.dart';
import 'package:fastor_app_ui_widget/resource/template/image/ImageView.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';



import 'package:fastor_app_ui_widget/resource/template/button/ButtonTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextTemplate.dart';

import 'package:flutter/cupertino.dart';
import 'package:umq/tools/values/ToolsValue.dart';

// ignore: camel_case_types
class cell_image_single extends StatelessWidget {

  String? value;
  double width;
  double? height;

  cell_image_single(this.value, this.width, { this.height});


  @override
  Widget build(BuildContext context) {
    return Stack( children: [
      box(),

      textNotAvaliable()
    ],);
  }

  Widget textNotAvaliable() {

    value ??=  "";

    var isNotDummy = value!.startsWith( "www.example.com") == false;
    if( ToolsValue.isValid( value ) &&
        isNotDummy
    ) {
      return  image();
    }


    return TextTemplate.t(   "NA",
        width:  width,
        levelDS: LevelDS.l3,
        padding: EdgeInsets.only(left: 5, top: 5),
        height: AdminDSDimen.row_height_m,
        gravityLayoutAlign: Alignment.topLeft,
        color: DSColor.table_row_title
    );
  }

  Widget image() {
    var testHe  = height??AdminDSDimen.row_height_m;
    Log.i("image() - w " + width.toString() + " /h: " + testHe.toString());
    return ImageView(width: width, height: height??AdminDSDimen.row_height_m,
    urlBackground: value,
    padding: EdgeInsets.all(5)
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