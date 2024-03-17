


import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/resource/resources/dimen/DimenResource.dart';
import 'package:fastor_app_ui_widget/resource/template/stack/StackTemplate.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/fastor/drawable/FastorDrawable.dart';

import 'package:hexcolor/hexcolor.dart';


class ToolbarHomeFastor extends StatefulWidget {

  String myTitle;
  BuildContext pageContext;

  ToolbarHomeFastor(this.pageContext, this.myTitle) ;


  @override
  ToolbarHomeFastorState createState()  {
    return  ToolbarHomeFastorState(myTitle  );
  }
}

class ToolbarHomeFastorState extends  State<ToolbarHomeFastor>   {

  String myTitle;
  ToolbarHomeFastorState(this.myTitle ) ;


  @override
  Widget build(BuildContext context) {
    return getToolbarBackground();
  }


  Widget getToolbarBackground(){
    var con = Container(
        height: ResourceDimen.toolbarHome_height,
        alignment: Alignment.topLeft,
        decoration: BoxDecoration(
          // color: Colors.green,
            image: DecorationImage(
                image: FastorDrawable.toolbar_2,
              fit: BoxFit.fitHeight,
              // opacity: 0.5
            )
        ),
        child: stackAllContent()
    );
    return con;
  }


  Widget stackAllContent() {
    return StackTemplate.child1AlignLeft_child2CenterHorizontal(
        imageBack(),
        title(),

        child1_marginTop: 10,
        child2_marginTop : 10);
  }


  Text title(){
    var txt =  Text( myTitle,
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: DSDimen.text_level_1,
            color: HexColor( "#ffffff" ),
            decoration:  TextDecoration.none
        )
    );
    return txt;
  }


  Widget imageBack() {
    var image = Image(image: FastorDrawable.camera_plus, width: 25 , height: 25 );
    var containter = Container(
        child: image,
        padding: EdgeInsets.all(5),
        margin: EdgeInsets.only( left: DSDimen.space_level_1  ),
        width: 25+5,
        height: 25+5
    );


    return  GestureDetector(
      //  splashColor: Colors.brown.withOpacity(0.5),
      onTap: (){

        Navigator.pop( widget.pageContext);

      },
      child: containter,
    );
  }




}