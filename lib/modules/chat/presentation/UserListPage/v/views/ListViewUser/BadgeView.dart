import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';

double badgeFrame = 25;

class BadgeView extends StatelessWidget {

  MChatMessage mMessage;
  int counterNotReaded;

  BadgeView(this.mMessage, this.counterNotReaded );


  @override
  Widget build(BuildContext context) {
    return _badgeView();
  }

  //--------------------------------------------------------- _badgeView

  Widget _badgeView(){
    //check have counter
    if( counterNotReaded == 0 ) {
      return EmptyView.zero();
    }

    _calculateFrame();

    //circle
    var ct = Container(
        child: _badgeTv( counterNotReaded),
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

  /**
      //when counter from 1 to 99 width is 25
   */
  void _calculateFrame() {
    if( counterNotReaded <= 99 ) {
      badgeFrame = 25;
      return;
    } else if( counterNotReaded <= 999) {
      badgeFrame = 30;
    } else if( counterNotReaded <= 9999) {
      badgeFrame = 55;
    } else {
      badgeFrame = 65;
    }
  }

  Widget _badgeTv(int counterNotReaded) {
    return TextTemplate.t( counterNotReaded.toString(),
        levelDS: LevelDS.l3,
        color: Colors.black87,
        width: badgeFrame,
        height: badgeFrame,
        textAlign: TextAlign.center,
      gravityLayoutAlign: Alignment.center
    );
  }

}