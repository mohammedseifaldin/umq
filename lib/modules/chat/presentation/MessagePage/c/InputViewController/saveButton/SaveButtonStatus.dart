import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';

extension SaveButtonStatus on InputMessageState {

  //------------------------------------------------------------- status of button

  Future setSaveButtonStatusText() async {

    //check already type txt
    if( isSaveButtonType_text ) return;
   // Log.i( "setSaveButtonStatusText()  "   ) ;

    //change ui
    setState(() {
      isSaveButtonType_text = true;
      isSaveButtonType_record = false;
    });
  }


  Future setSaveButtonStatusRecord() async  {
    //check already type txt
    if( isSaveButtonType_record ) return;
    //Log.i( "setSaveButtonStatusRecord()  "   ) ;

    //change ui
    setState(() {
      isSaveButtonType_text = false;
      isSaveButtonType_record = true;
    });
  }



}