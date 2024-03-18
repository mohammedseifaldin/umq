import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/record/RecordController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/saveButton/CreateMessageController.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ButtonSaveController on InputMessageState {


  Future buttonSaveClick() async  {
   // Log.i( "buttonSaveClick()"   ) ;

    bool isValid = await validate();
    if( isValid == false ){
     // Log.i( "buttonSaveClick() - isValid - stop!");
      return;
    }


    if( isSaveButtonType_text ) {
     // Log.i( "buttonSaveClick() - isSaveButtonType_text");
      await createMessageTypeText();
      return;
    }

    if( isSaveButtonType_record ) {
    //  Log.i( "buttonSaveClick() - isSaveButtonType_record");
      await clickOnRecordIcon();
    }
  }


  Future<bool> validate() async {
    var result = true; //default

    //case message text
    if( isSaveButtonType_text ) {
      if ( ToolsValidation.isEmpty( msg_txt )   ){
        ToolsToast.i(context,  "Type a message");
        return false;
      }
    }

    //case recorder
    if( isSaveButtonType_record ) {
      return await _valid_type_record();
    }

    return result;
  }


  Future<bool> _valid_type_record() async {


    //a- case progress still show
    if( prg_recorder ) {
      ToolsToast.i(context,  "Wait to upload previous recorder");
      return false;
    }

    //b- check size duration of file
    // String uri = RecorderSoundInstance.pathDefaultFile;
    // bool validRecord = await ToolsMeta.isValidAudioSize(uri );
    // if( validRecord == false ) {
    //   ToolsToast.i(context,  "Very small record duration");
    // }
    return true;
  }

}