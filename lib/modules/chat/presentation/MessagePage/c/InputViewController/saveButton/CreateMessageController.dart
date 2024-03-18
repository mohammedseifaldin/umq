import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/InputViewUpdateUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/tools/keyboard/ToolsKeyboard.dart';

extension CreateMessageController on InputMessageState {

  Future createMessageTypeText() async {

    int receiverId = chatMessageState.widget.userTargetSmall!.id;

    //map data
    MChatMessage mMessageNew = ToolsMChatMessage.generateText(
        msg_txt,
        chatMessageState.myUserId,
        receiverId) ;

    //update ui before api
    await clearInputView();
    await updateUIAfterInputFieldChange( "");
    await ToolsKeyboard.dismiss( chatMessageState.context);

    // api
   await chatMessageState.apiCreateMessage(mMessageNew);

  }






}