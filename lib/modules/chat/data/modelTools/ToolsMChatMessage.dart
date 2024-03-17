import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/shared/toolsChat/constant/EReadStatus.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';

import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/time/TimeTools.dart';

class ToolsMChatMessage {


  //------------------------------------------------------------------ owner of message

  static bool isSender(MChatMessage m , int userId )    {
    if( m.senderId == null )return false;

    return m.senderId == userId ;
  }


  static bool isReceiver(MChatMessage m , int userId)    {
    if( m.receiverId == null )return false;
    return m.receiverId == userId ;
  }

  //------------------------------------------------------------------ message type

  static bool  isTypeTextOnly(MChatMessage m )    {
    return ToolsValidation.isEmpty( m.text ) == false  ;
  }

  static bool  isTypeImage(MChatMessage m )    {
    return ToolsValidation.isEmpty( m.image ) == false  ;
  }

  static bool  isTypeRecorder(MChatMessage m )    {
    return ToolsValidation.isEmpty( m.recorder ) == false  ;
  }


  //-------------------------------------------------------------------------- date of message

  static String getHumanDate(MChatMessage mChatMessage) {
    if( mChatMessage.createdAt == null ) return "";

    // case day name
    if(  TimeTools.isToday( mChatMessage.createdAt!)) {
      return TimeTools.timestampToDate_hh_mm(mChatMessage.createdAt!);
      //return "Today";
    }
    if(  TimeTools.isYesterday( mChatMessage.createdAt!) ) {
      String hhmm = TimeTools.timestampToDate_hh_mm(mChatMessage.createdAt!);
      return "Yesterday " + hhmm;
    }

    //#abdallah:  delay
    return TimeTools.convertTimestamp_yyymmddhhmmPM( mChatMessage.createdAt!);
  }


  //------------------------------------------------------------------ generate

  static MChatMessage generateText(String msg_txt, int myUserId, int receiverId ) {
    MChatMessage m = new MChatMessage();
    m.text = msg_txt;
    m.senderId = myUserId;
    m.status_read = EReadStatus.wait.toString();
    m.receiverId = receiverId;
    m.senderWaitId = TimeTools.getCurrentTimestamp();
    return m;
  }


  static MChatMessage generateFile(String filePath, int myUserId, int receiverId ) {
    MChatMessage m = new MChatMessage();
    m.image = filePath;
    m.senderId = myUserId;
    m.status_read = EReadStatus.wait.toString();
    m.receiverId = receiverId;
    m.senderWaitId = TimeTools.getCurrentTimestamp();
    return m;
  }


  static MChatMessage generateRecorder(String filePath, int myUserId, int receiverId ) {
    MChatMessage m = new MChatMessage();
    m.recorder = filePath;
    m.senderId = myUserId;
    m.status_read = EReadStatus.wait.toString();
    m.receiverId = receiverId;
    m.senderWaitId = TimeTools.getCurrentTimestamp();
    return m;
  }


  //---------------------------------------------------------------------- filter

  static final int notFound = -1;

  /**
   * search in list to found index of this id
      - case not found :  retrun -1
      - case found : return value index of array
   */
  static Future<int> indexOfThisIdAtList(List<MChatMessage> listMessageData, int? idSearch)  async {
    if( idSearch == null ) return notFound ;
    if( listMessageData.isEmpty ) return notFound;

    var result = notFound;

    for( int i = 0; i < listMessageData.length; i++ ){
      MChatMessage m  = listMessageData[ i ];

      //check found idSearch
      if( m.id == idSearch  ) {
        result = i;
        break ;
      }

    }

    return result;
  }



}