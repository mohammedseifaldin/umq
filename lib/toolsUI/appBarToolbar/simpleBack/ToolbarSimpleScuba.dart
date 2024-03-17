import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ToolbarSimpleScuba extends StatefulWidget {

  BuildContext pageContext;
  String title;
  ToolbarSimpleScuba(this.pageContext, this.title);

  static double height = 50;

  @override
  ToolbarSimpleState createState() {

    return ToolbarSimpleState();
  }

}


class ToolbarSimpleState extends State<ToolbarSimpleScuba> {


  @override
  Widget build(BuildContext context) {
    return toolbar();
  }


  Widget toolbar(){
    return Container(
       //
        width: DeviceTools.getWidth(context),
        height: 50, child:  contentToolbar());
  }



  Widget contentToolbar() {
    var row =  Stack(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [

          //empty
          EmptyView.empty( DeviceTools.getWidth(context), 50 ),

          //back
          Positioned(child: im_backbutton(),
            left: 0,
            top: 0,
            bottom: 0,
          ),

          //title
          Positioned(child: tv_title(), top: 10, left: 0, right: 0  ),
    

        ]);

    return Material( child: Container(child: row,
      color: HexColor(ColorProject.grey), //background toolbarMessage
    )  );
  }


  Widget tv_title(){
    return TextTemplate.t( widget.title,
                levelDS: LevelDS.l1);
  }

  Widget im_backbutton(){
    var asset = AssetImage( "assets/fastor/arrow_back_black.png");
    var back = ImageView( width: 35, height: 35,
    padding: EdgeInsets.all(10),
    onPressed: (){
      Log.i( "im_backbutton() - ImageView  click" );
      //finish class
      Navigator.pop( widget.pageContext  );
    },
    assetAspectRatio: asset);


    return GestureDetector( child:  back,
    onTap: (){
      Log.i( "im_backbutton() - surround area back" );
      //finish class
      Navigator.pop( widget.pageContext  );
    },
    );
  }
}