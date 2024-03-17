
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DimenProject.dart';

class ScubaScaffoldSimple extends StatelessWidget {

  String title;
  Widget childContentPage;

  BuildContext? context;

  static double heightTransparentCard = 40.0;

  ScubaScaffoldSimple(this.title, this.childContentPage );

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return getScaffoldWithAppBar();
  }


  //----------------------------------------------------- type: show app bar

  Widget getScaffoldWithAppBar() {
    return Scaffold(
        backgroundColor: DSColor.ds_background_toolbar, // ColorProject.grey
        appBar: getAppBar(),
        body: SafeArea( child: contentPage() )
    );
  }


  // Widget stackAppBarWithChild(){
  //   return Stack( children: [
  //     EmptyView.allDeviceScreen(context!),
  //     contentChildPage(),
  //
  //     getAppBar()
  //   ],);
  // }


  AppBar getAppBar(){

    return AppBar(
      backgroundColor: DSColor.ds_background_toolbar, //ColorProject.grey
      elevation: 0,
      leading: BackButton(color: Colors.black),
      title: Text(
        title,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
      ),
      centerTitle: true,
    );
  }


  Widget contentPage(){
    return Container(
      // margin: EdgeInsets.only(top: 80),
      padding: EdgeInsets.fromLTRB(15, 0 , 15, 0),
      decoration: cardDecoration(),
      // color: ,
      child: childContentPage,
    );
  }


  BoxDecoration cardDecoration() {
    return BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(DimenProject.radiusScaffoldCorner * 0.5 )
        ));
  }

}