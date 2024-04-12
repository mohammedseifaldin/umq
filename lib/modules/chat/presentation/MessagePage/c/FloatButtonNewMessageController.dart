import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';

extension FloatButtonNewMessageController on ChatMessageState {
  Future setFoundNewMessage(MChatMessage m) async {
    Log.i("setFoundNewMessage() id: ${m.id}");

    //check is i'm receiver
    bool isAmReceiver = ToolsMChatMessage.isReceiver(m, myUserId);
    if (isAmReceiver) {
      /**
          when user still at page 1 not load history
       */
      if (page == 2) {
        socketFoundNewMessageIamSender = true;

        /**
            show float button when user show page at history
         */
      } else if (page > 2) {
        floatButtonStatus = true;
      }
      return;
    }

    //check first page, no need to show arrow
    /**
     * arrow show only to notify user there is new message, while user see history pages
     */
    bool isAmSender = ToolsMChatMessage.isReceiver(m, myUserId);
    if (isAmSender) {
      socketFoundNewMessageIamSender = true;
      return;
    }
  }

  Future setHideFloatButtonNow() async {
    setState(() {
      floatButtonStatus = false;
    });
  }

  Future initFloatButtonNewMessageCome(List<MChatMessage> listFiltered) async {
    //check no need to dothing
    if (floatButtonStatus == false) {
      return;
    }

    // //now show for a while the button
    // ToolsWait.waitToDo( 3000, () async  {
    //   await setHideFloatButtonNow();
    // } );
  }
}
