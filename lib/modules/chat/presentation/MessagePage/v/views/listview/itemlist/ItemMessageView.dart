import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/receiver/ReceiverMediaFormat.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/receiver/ReceiverRecorderFormat.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/receiver/ReceiverTextFormat.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/sender/SenderMediaFormat.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/sender/SenderRecorderFormat.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/sender/SenderTextFormat.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';

import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';

//======================================================================== item type statefullwidget


class ItemMessageStateFullWidget extends StatefulWidget {


  int position;
  MChatMessage mChatMessage;

  ChatMessageState parentState;
  // State?

  //recorder
  bool isRecorderStartPlaying = false;
  bool isSyncListenerRecorderStatus = false;

  ItemMessageStateFullWidget( this.parentState, this.position, this.mChatMessage);


  @override
  ItemMessageStateFullWidgetState createState() {

    return ItemMessageStateFullWidgetState();
  }

}

class ItemMessageStateFullWidgetState extends State<ItemMessageStateFullWidget> {
  @override
  Widget build(BuildContext context) {
    //Log.i("build() - ItemMessageStateFullWidgetState");
    return ItemMessageState( widget.parentState, widget.position, widget.mChatMessage,
        itemStatefullwidget: this );
  }

}

//======================================================================== item type statelesswidget

class ItemMessageState extends StatelessWidget {

  //------------------------------------------------------------ variable

  int position;
  MChatMessage mChatMessage;

  //state variables
  ChatMessageState parentState;
  ItemMessageStateFullWidgetState? itemStatefullwidget;

  ItemMessageState( this.parentState, this.position, this.mChatMessage, {
    this.itemStatefullwidget
  });

  //------------------------------------------------------------ build

  BuildContext? viewBuildContext;

  @override
  Widget build(BuildContext context) {
   // this.myState =myState;
    this.viewBuildContext = context;

    //Log.i(  "build() - StatelessWidget"   );
    return ItemMessageViewItem( );
  }


  /**
   * choose type of message :
   *   1- date
   *   2- sender
   *   3- receiver
   */
  Widget ItemMessageViewItem( ) {

    //check type date message
    if( mChatMessage.typeDateMessage != null ) {
      return getMessageTypeDate(  );
    }

    //choose type owner
    bool isSenderType = ToolsMChatMessage.isSender(mChatMessage, parentState.myUserId );
    if(  isSenderType  ) {
      return getMessageSenderView(  );
    } else {
      return getMessageReceiverView(  );
    }
  }


  //------------------------------------------------------------  date types

  Widget getMessageTypeDate( ) {
    var tv  = TextTemplate.t( mChatMessage.typeDateMessage,
        padding: EdgeInsets.all( 10 ),
        backgroundColor: ChatColor.dateMesasge_card_background,
        levelDS: LevelDS.l2 );

    return Container(
      child: tv,
      width: DeviceTools.getWidth(parentState.context),
    );
  }

  //----------------------------------------------------------------- type receiver

  Widget getMessageReceiver() {
    //typeRelation: text
    if( ToolsMChatMessage.isTypeTextOnly( mChatMessage ) ) {
      return formatTextViewReceiver( );
    }

    return formatTextViewReceiver( );
  }
  /**
      choose type of typeRelation
   */
  Widget getMessageReceiverView(  ) {

    //type format
    if( ToolsMChatMessage.isTypeTextOnly( mChatMessage ) ) {
      return formatTextViewReceiver( );
    }
    if( ToolsMChatMessage.isTypeImage( mChatMessage ) ) {
      return formatImageReceiver( );
    }
    if( ToolsMChatMessage.isTypeRecorder( mChatMessage ) ) {
      return formatRecorderReceiver( );
    }
    return formatTextViewReceiver( );
  }


  //------------------------------------------------------------------- type sender


  Widget getMessageSenderView( ) {

    //type Format
    if( ToolsMChatMessage.isTypeTextOnly( mChatMessage ) ) {
      return formatTextViewSender( );
    }
    if( ToolsMChatMessage.isTypeImage( mChatMessage ) ) {
      return formatImageSender( );
    }
    if( ToolsMChatMessage.isTypeRecorder( mChatMessage ) ) {
      return formatRecorderSender( );
    }
    //default
    return formatTextViewSender( );
  }





}