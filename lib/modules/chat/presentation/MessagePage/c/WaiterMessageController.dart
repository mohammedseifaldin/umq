import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/FloatButtonNewMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/ScrollMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/m/MapDataChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/socketWaiter/SocketWaiterSingleTone.dart';

extension WaiterMessageController on ChatMessageState {


  Future initWaiterMessage() async {
    //checker
    if( isStartWaiterBefore ) return;
    isStartWaiterBefore = true;
   Log.i( "initWaiterMessage() - isStartWaiterBefore: " + isStartWaiterBefore.toString() );

    //listener
    SocketWaiterSingleTone.instance().addWaiterChatMessage(   (listUpdate ) async {
     // Log.i( "initWaiterMessage() - listUpdate: " + listUpdate.length.toString() );

      //filter message in this chat
      List<MChatMessage> listFiltered = await filterMessageWithThisUser(listUpdate);

      if( listFiltered.length == 0 ) return;

      // append data
      await socketPushListData( listFiltered);

      //  map view
     await mapObjectToView( );

     // float button new message come
     await initFloatButtonNewMessageCome(listFiltered);

     // refresh
     await stateRefreshToNewMessageInList();

     //scroll to new
      await scrollEventSocketWaiterAdded(   );

    });
  }


  Future<List<MChatMessage>> filterMessageWithThisUser(List<MChatMessage> listUpdate) async {
    //
    List<MChatMessage> listFiltered = [];
    for ( int i = 0 ; i < listUpdate.length; i++ ){

      //get
      MChatMessage m = listUpdate[i];

      //check target sender
      bool isTargetSender = ToolsMChatMessage.isSender(m, chatTargetId );
      if( isTargetSender  ) {
        listFiltered.add( m );
        continue;
      }

      //check target receiver
      bool isTargetReceiver = ToolsMChatMessage.isReceiver(m, chatTargetId );
      if( isTargetReceiver  ) {
        listFiltered.add( m );
      }

    }
    return listFiltered;
  }

}