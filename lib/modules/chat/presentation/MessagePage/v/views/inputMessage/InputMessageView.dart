import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/BoarderLayout.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/ButtonSaveView.dart';
import 'package:umq/modules/chat/shared/toolsChat/resource/ChatColor.dart';
import 'package:umq/toolsUI/textField/CheckerHeightTextField.dart';


class InputMessageWidget extends StatefulWidget {


  ChatMessageState chatMessageState;

  InputMessageWidget(this.chatMessageState);

  @override
  InputMessageState createState() {
    return InputMessageState(chatMessageState);
  }

}
class InputMessageState extends State<InputMessageWidget> {

  //------------------------------------------------------------------- variable


  //frame
 static double height_Frame  = 50 ;
 double frame_width_cameraAndAttachView = 80;
 double buttonSave_frame_widht = 62;

 // save
  var isSaveButtonType_text = false;
  var isSaveButtonType_record = true;

 //textfield
  CheckerHeightTextField? checkerHeightTextField;
  var msg_txt = "";
  var msg_valid = AutovalidateMode.disabled;
  var msg_controller = TextEditingController();

 //recorder
 bool isRecorderRun = false;

  //parent
 ChatMessageState chatMessageState;

 //progress
 bool prg_attachFile = false;
 bool prg_capture = false;
 bool prg_recorder = false;

 InputMessageState(this.chatMessageState);


 //------------------------------------------------------------------- build

 @override
 Widget build(BuildContext context) {

   return getInputMessageView();
   // return getContainerLayoutInput(); prg_capture
 }

 //--------------------------------------------------------------- input view

  Widget getInputMessageView(){
    return Stack( children: [

      //frame height
      EmptyView.colored(DeviceTools.getWidth(context ),
          height_Frame,
          ChatColor.inputView_background
      ),

     // emotionIcon(),

      //boarder
      getContainerLayoutInput(),

      //button save
       Positioned(child:  getButtonSave(), right: 0 )

    ],);
  }


 /** -- not at this app need emotion
  *
     Widget emotionIcon() {
     return ImageView(width:  40, height: 40 ,
     padding: EdgeInsets.all( 5) ,
     assetAspectRatio: ChatDrawable.images( "emoji_icon"),
     );
     }
  */




}