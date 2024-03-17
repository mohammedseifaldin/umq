import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/MessageViewToolsUI.dart';
import 'package:umq/modules/chat/data/source/message/ChatMessageStatusAPI.dart';

import 'package:umq/modules/chat/shared/toolsChat/constant/EReadStatus.dart';
import 'package:umq/modules/chat/shared/toolsChat/constant/ToolsEnumReadStatus.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/tools/audio/AudioSingleTone.dart';

extension ItemListRecorderController on ItemMessageState {

  Future playOrPauseRecorder() async {


    //listener
    listenerRecorderStatus();

    //choose type
    if( getStatusRecorderStartPlaying() ) {
      await _typeButtonPause();
    } else {
      await _typeButtonPlay();
    }
  }

  //--------------------------------------------------------------- button stop

  Future _typeButtonPause() async {
    await AudioSingleTone.stop();

    await _updateUIRecorder(false);

  }

  //--------------------------------------------------------------- button play

  Future _typeButtonPlay() async {
    //play
    await AudioSingleTone.playLink( mChatMessage.recorder??"" );

   // await _updateUIRecorder(true);

    await _recorderReaded();

    // await listenerRecorderStatus();
  }



  Future _recorderReaded() async {

    //check iam not sender
    bool isIamSender = ToolsMChatMessage.isSender(mChatMessage, parentState.myUserId );
    if( isIamSender) {
      //Log.i(  "_apiUpdateStatusRecord() - isIamSender - stop !"  );
      return;
    }


    //check readed
    bool isReadedBefore = ToolsEnumReadStatus.isReaded(mChatMessage  );
    if( isReadedBefore) {
      //Log.i(  "_apiUpdateStatusRecord() - isReadedBefore - stop !"  );
      return;
    }

    //api
    await _apiUpdateStatusRecord();
  }


  Future _apiUpdateStatusRecord() async {

    //call api
    ChatMessageStatusAPI().readed(messageId: mChatMessage.id.toString(),
        allowChangeRecorder: true,
        callBack: (status, msg, response ) {

          if( status ){
            mChatMessage.status_read = EReadStatus.readed.toString();
          }
          //Log.i(  "_apiUpdateStatusRecord() - ChatMessageStatusAPI - response " + response.toString()  );
        } );
  }

  //--------------------------------------------------------------- update ui + listener

  Future listenerRecorderStatus()  async {
    bool isSync = itemStatefullwidget!.widget.isSyncListenerRecorderStatus;
   // Log.i(  "listenerRecorderStatus() - isSync " + isSync.toString()  );
    //check sync before
    if(  isSync  ) {
      return;
    }
    itemStatefullwidget!.widget.isSyncListenerRecorderStatus = true;

    //waitier init
    final link = mChatMessage.recorder ;
    AudioSingleTone.addListenerRecorderStatus( link!,  (isPlaying ) async {
      Log.i( "listenerRecorderStatus() - AudioSingleTone.lastLinkPlayed: " + AudioSingleTone.lastPlayed.toString() );


      //check complete sound
      _updateUIRecorder( isPlaying );

    });
  }


  Future _updateUIRecorder(bool updateStatus) async {

    //set value
    itemStatefullwidget!.widget.isRecorderStartPlaying = updateStatus;

    //check mounted
    if( itemStatefullwidget!.mounted ==  false )return;

    itemStatefullwidget!.setState( () {
    //   Log.i(  "_updateUIRecorder()  - updateStatus: " + updateStatus.toString()
    // + " /itemStatefullwidget: " + itemStatefullwidget.toString() );
      itemStatefullwidget!.widget.isRecorderStartPlaying = updateStatus;
    });

    // build( viewBuildContext!);
  }



}