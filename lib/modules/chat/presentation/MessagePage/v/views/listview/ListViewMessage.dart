import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/m/MapDataChatMessage.dart';

import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';

import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';

extension ListViewMessage  on ChatMessageState {


  Widget getListViewMessage(){


    return ColumnTemplate.t( children: [

      firstMessageInHistory(),
      //listViewMessageNewAddedByPaginate(),
      listViewMessageOldData(),
      //margin
      EmptyView.empty( DSDimen.space_level_4, DSDimen.space_level_4)

    ]);
  }


  // Widget listViewMessageNewAddedByPaginate(){
  //
  //   return ColumnTemplate.t( children: listMessageViewOld);
  // }


  Widget listViewMessageOldData(){
    return ColumnTemplate.t( children: listMessageViewOld);

    // return ListView.builder(
    //   itemCount: listMessageViewOld.length,
    //   scrollDirection: Axis.vertical,
    //   shrinkWrap: true,
    //   itemBuilder: (context,index) {
    //     //Text(propList[index]
    //
    //     return listMessageViewOld[ index ];
    //   });

    // return StreamBuilder(
    //     stream: myStream ,
    //
    //     builder: (context, snapshot) {
    //       //Text(propList[index]
    //
    //       MChatMessage mChatMessage = snapshot as MChatMessage;
    //       return ItemMessageState(this, 0, mChatMessage);
    //     });

    // return StatefulBuilder(
    //     builder: (BuildContext context, StateSetter innerState ) {
    //
    //       this.innerState = innerState;
    //   return ColumnTemplate.t( children: listMessageViewOld);
    // });

  }


  Widget firstMessageInHistory() {

    //check not end yet
    if( isFinishAllPages == false ) {
      return EmptyView.zero();
    }

    //show first message
    return TextTemplate.t( "Welcome with " + EnvironmentConstant.appName,
    margin: EdgeInsets.all(  DSDimen.space_level_3  ),
    levelDS: LevelDS.l3
    );
  }


}
