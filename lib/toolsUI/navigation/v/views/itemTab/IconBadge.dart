import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/navigation/m/ModelNavigation.dart';


double badgeFrame = 15;

class IconBadge extends StatelessWidget {

  ModelNavigation model;

  IconBadge(this.model  );


  @override
  Widget build(BuildContext context) {
    return _badgeView();
  }

  //--------------------------------------------------------- _badgeView

  Widget _badgeView(){

    // _calculateFrame();

    //circle
    var ct = Container(
        child: _badgeTv( model.badgeCounter!),
        alignment: Alignment.center,
        width: badgeFrame,
        height: badgeFrame,
        padding: EdgeInsets.all(5 ), //boarder width
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white
        ));
    return ct;
  }

  // /**
  //     //when counter from 1 to 99 width is 25
  //  */
  // void _calculateFrame() {
  //   if( model.badgeCounter! <= 99 ) {
  //     badgeFrame = 25;
  //     return;
  //   } else if( model.badgeCounter! <= 999) {
  //     badgeFrame = 30;
  //   } else if( model.badgeCounter! <= 9999) {
  //     badgeFrame = 55;
  //   } else {
  //     badgeFrame = 65;
  //   }
  // }

  Widget _badgeTv(int counterNotReaded) {
    return TextTemplate.t( counterNotReaded.toString(),
        levelDS: LevelDS.l3,
        color: Colors.black87,
        dimen: 6,
        fontFamily: FontProject.beach,
        width: badgeFrame,
        height: badgeFrame,
        textAlign: TextAlign.center,
      gravityLayoutAlign: Alignment.center
    );
  }

}