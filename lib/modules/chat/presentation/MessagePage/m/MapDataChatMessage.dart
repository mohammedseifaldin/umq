import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/FloatButtonNewMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/listview/itemlist/ItemMessageView.dart';

extension DataChatMessage on ChatMessageState {

  //--------------------------------------------------------------------- map obj to view

  Future mapObjectToView() async {
    listMessageViewOld = [];
    for( int i = 0; i < listMessageDataOld.length; i++ ) {
      MChatMessage m = listMessageDataOld[i];

      //choose type "statefullwidget"
      bool isTypeStateFullwidget = ToolsMChatMessage.isTypeRecorder( m );
      if( isTypeStateFullwidget) {
        var itemView  = ItemMessageStateFullWidget( this,  i, m    );
        listMessageViewOld.add(itemView  );
      } else {
        var itemView  = ItemMessageState( this,  i, m    );
        listMessageViewOld.add(itemView  );
      }




    }
  }

  //--------------------------------------------------------------------- append history

  /**
   get all message in history between two users
   */
  Future appendedHistoryData( List<MChatMessage> listNew ) async {
    if( listNew.length == 0 ) return;

    //revert from new to old,
    // because the scroll is to see history by moving the touch  to move to Top screen
    List<MChatMessage> listReverse = [];
    int lastItemIndex = listNew.length-1;
    for( int i =  lastItemIndex; i >= 0 ; i--  ){
      MChatMessage m = listNew[i];
      listReverse.add( m );
    }

    //set to all listMessage with shift already downloaded to end of array
    listMessageDataOld.insertAll(0 , listReverse );

    //log for test
    /**
        listMessageData.forEach( (e) {
        Log.i( "appendedNewData() - e: " + e.id.toString() );
        });
     */

    //state change
   // stateRefreshToNewMessageInList();
  }

  //------------------------------------------------------------------- socket data

  Future socketPushListData(List<MChatMessage> listFiltered ) async  {

    listFiltered.forEach((m) async {
      await _socketDataSingle( m );
    });


    //log for test
    // listMessageData.forEach( (e) {
    //   Log.i( "socketPushListData() - e: " + e.id.toString() );
    // });

  }


  Future _socketDataSingle(MChatMessage m ) async {
    //case new message
    bool isNewMessage = listMessageDataOld.isEmpty ||
        (listMessageDataOld.last.id! <  m.id!);
    if( isNewMessage ) {
      await addNewMessageCreated(m);
      await setFoundNewMessage( m );
      return;
    }

    //case message found in history
    /**
    - case not found index return "-1" is constant
    - case found index at history, now replace the data
     */
    int indexAtHistory =  await ToolsMChatMessage.indexOfThisIdAtList( listMessageDataOld, m.id );
    bool isFoundAtHistory = indexAtHistory != ToolsMChatMessage.notFound;
    if( isFoundAtHistory ) {
      listMessageDataOld[ indexAtHistory] = m;
      return;
    }

    //case old message changes, while not shown in list downloaded history
    /**
     Do Nothing
     */
    return ;
  }

  //------------------------------------------------------------------------ tools

  Future addNewMessageCreated( MChatMessage m  ) async {
    listMessageDataOld.add( m  );

    // //case i'm is sender, cause to focus to bottom of screen
    // bool isIamSender = ToolsMChatMessage.isSender(m,  myUserId );
    // if( isIamSender ) {
    //   focusBottomScreenRapid();
    // }
  }


  Future stateRefreshToNewMessageInList() async {
    setState( (){

    });
  }


}