
import 'package:umq/modules/chat/data/model/MChatUser.dart';

class ToolsMChatUser {

  /**
   get another person chat with me
   */
  static int getAnotherPerson(int myUserId, MChatUser mChatUser ) {
    bool isIamPersonA = mChatUser.personA == myUserId;
    bool isIamPersonB = mChatUser.personB == myUserId;
    if( isIamPersonA) {
      return mChatUser.personB!;
    }
    if( isIamPersonB) {
      return mChatUser.personB!;
    }
    return 0;
  }


  static bool isIamPersonA(int myUserId, MChatUser mChatUser ) {
    bool isIamPersonA = mChatUser.personA == myUserId;
    return isIamPersonA;
  }


  static bool isIamPersonB(int myUserId, MChatUser mChatUser ) {
    bool isIamPersonB = mChatUser.personB == myUserId;
    return isIamPersonB;
  }

}