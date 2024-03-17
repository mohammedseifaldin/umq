import 'dart:math';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/saveButton/SaveButtonStatus.dart';

import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/CameraAndAttachView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/TextFieldChat.dart';
import 'package:umq/toolsUI/textField/CheckerHeightTextField.dart';

extension InputViewUpdateUI on InputMessageState {

  Future updateUIAfterInputFieldChange(String s )  async {
  //  Log.i( "updateUIAfterInputFieldChange() - s: " + s  );

    //case: empty initlize to firsStat
    if( ToolsValidation.isEmpty( s ) ) {
      await initializeToFirstCreatePage();
      //change save button type
      await setSaveButtonStatusRecord();
      return;
    }

    //change save button type
    await setSaveButtonStatusText();

    //case: first character
    if(  s.length == 1 ) {
      await hideRowAttach();
      return;
    }

    //case: many lines increase
    if( ToolsValidation.isValid(  s )) {
      await changeHeightOfTextfieldFrame(s);
      return;
    }

  }


  Future initializeToFirstCreatePage() async {
    frame_width_cameraAndAttachView = 80;
    InputMessageState.height_Frame = 50;

    setState((){});
  }


  Future hideRowAttach() async {
    frame_width_cameraAndAttachView = 0;
    setState((){});
  }


  Future changeHeightOfTextfieldFrame(String txt ) async {

    // checker height change
    checkerHeightTextField!.updateText( txt   );
  }


  void startCheckerHeightTextField() {
    checkerHeightTextField =  CheckerHeightTextField(
      txt: "",
        tf_frame_width: getWidthOfFrameTextField(),
        maxLine :4 ,
        margin : 14,
      callBackHeight: ( newHeight ) {

        //save to state
        chatMessageState.setState( (){

          InputMessageState.height_Frame = newHeight  ;
        });

      }
    );
  }


  Future clearInputView() async {
    setState( (){
      msg_controller.text = "";
      msg_txt = "";
    });

  }

}