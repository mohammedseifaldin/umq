
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/c/ClickActionsDetails.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/v/SliderDetailAdminPage.dart';

import 'package:umq/tools/resourceProject/ResourceDimenAdmin.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';


extension ContentDetail on SlideDetailAdminState {


  //------------------------------------------------------------------- photo

  Widget photo(){
    return ColumnTemplate.t( children: [
      tv_photo(),
      im_photo()
    ],
        margin: EdgeInsets.only(left: DSDimen.space_level_2)
    );
  }


  Widget tv_photo() {
    return TextTemplate.t( "photo",
        levelDS: LevelDS.l2,
        margin: EdgeInsets.only(top: DSDimen.space_level_2)
    );
  }

  Widget im_photo(){
    var im = photo_image();

    var cont =  Container(
      child:  im,
      width: 200 ,
      height: 140 ,
      // color: Colors.red,
      margin: EdgeInsets.only(top:   DSDimen.space_level_3 ),
      padding: EdgeInsets.all( 3 ),
      decoration: BoarderHelper.box(

        colorLine: DSColor.table_row_boader //color of admin table boarder
      ),
    );

    return cont;
  }


  Widget photo_image() {

    var im =  ImageView(
      width: AdminDSDimen.inputFiled_value_width,
      height: AdminDSDimen.inputFiled_value_width,
      assetAspectRatio: DrawableProject.placeholderImage,
      urlBackground: photo_url_selected,
      onChangeState: (value) {
        photo_state = value;
        // Log.i( "photo_image() - photo_state "   + photo_state!.toString( ));
      }, onPressed: () async {
      await photo_click();
    },
    );

    return Stack(children: [
      im,
      photo_progress()
    ],);
  }


  Widget photo_progress(){
    if(photo_progress_status == false ) {
      return EmptyView.zero();
    }

    return ProgressSpinkit.get();
  }

  //------------------------------------------------------------ save

  Widget save(){
    var bt = ButtonTemplate.t( "save", () {
      save_click();
    },
    margin: EdgeInsets.only(top: DSDimen.space_level_2 + 2 ,
    bottom: DSDimen.space_level_1 )
    );

    return Container( child: bt,
    alignment: Alignment.center,
    );
  }




}