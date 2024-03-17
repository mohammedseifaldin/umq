import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';

extension ProgressMessageController on ChatMessageState {

  Future startProgress() async {
    setState((){
      progressStatus = true;
      isWaitingForPreviousLoading = true;
    });
  }


  Future stopProgress() async {
    setState((){
      progressStatus = false;
      isWaitingForPreviousLoading = false;
    });
  }


}