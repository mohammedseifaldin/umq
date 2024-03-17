import 'package:umq/modules/chat/shared/toolsChat/constant/EReadStatus.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';

class ToolsEnumReadStatus {


  static bool  isWait( MChatMessage mChatMessage ) {
    if( mChatMessage.status_read == null ) return false;
    return mChatMessage.status_read == EReadStatus.wait.name;
  }

  static bool  isReaded( MChatMessage mChatMessage ) {
    if( mChatMessage.status_read == null ) return false;
    return mChatMessage.status_read == EReadStatus.readed.name;
  }


  static bool  isReceived( MChatMessage mChatMessage ) {
    if( mChatMessage.status_read == null ) return false;
    return mChatMessage.status_read == EReadStatus.received.name;
  }


  static bool  isSend( MChatMessage mChatMessage ) {
    if( mChatMessage.status_read == null ) return false;
    return mChatMessage.status_read == EReadStatus.send.name;
  }

}