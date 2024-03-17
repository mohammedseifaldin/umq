
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class ToolbarProjectBack extends StatelessWidget {

  String title;
  BuildContext  contextPage;
  static const frameHeight = 50.0;

  bool isHideBackButton = false;
  ValueChanged? onBackClick;


  ToolbarProjectBack(this.contextPage, this.title, {
    bool? isHideBackButton = false ,
    ValueChanged? this.onBackClick
}){
    this.isHideBackButton = isHideBackButton!;
  }


  @override
  Widget build(BuildContext context) {

    return getContent();
  }


  Widget getContent() {
    return Container(
      height: ToolbarHomeScuba.frameHeight,
      width: DeviceTools.getWidth(contextPage), //MediaQuery.of(context).size.width
      color:      DSColor.ds_background_toolbar,
      child:  getStack(),
    );
  }

  Widget getStack(){
    return Stack( children: [

      //toolbar size
      EmptyView.empty( DeviceTools.getWidth(contextPage),
          frameHeight ),

      //back button
      Positioned(child:  backBt(), left: DSDimen.space_level_1 , top: 0, bottom: 0,),

      //title
      Positioned(child:  titleToolbarTv(), left: 0, right: 0 , top:  10, )

    ],);
  }


  Widget backBt(){

    //check hide
    if( isHideBackButton ) {
      return EmptyView.zero();
    }

    return  GestureDetector(
      onTap: () {

        //check have customer
        if( onBackClick != null   ) {
          onBackClick!( true );
          return;
        }

        //kill page
        Navigator.pop(contextPage);
      },
      child: Container(
        color: Colors.transparent,
        child: const Icon(
          CupertinoIcons.back,
          size: 25,
          color: Colors.black,
        ),
      ),
    );
  }


  Widget titleToolbarTv() {
    return TextTemplate.t( title,
    levelDS: LevelDS.parent
    );
  }


}
