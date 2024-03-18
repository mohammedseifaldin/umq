import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/chat/presentation/MessagePage/c/InputViewController/InputViewUpdateUI.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';

extension TextFieldChat on InputMessageState {


  Widget getTextFieldChat(){

    startCheckerHeightTextField();

    var tf=  TextFieldFastor(
        hint_text: "Type a message",
        width: getWidthOfFrameTextField() ,
     //   background_color: Colors.yellow, //test
        background_color: Colors.transparent,
        isRemoveUnderline: true,
        autovalidateMode: msg_valid,
        controller: msg_controller,
        maxLines: null ,
        // margin: EdgeInsets.only(top: DSDimen.space_level_3),
        padding: EdgeInsets.all(  DSDimen.textfield_auto_padding ),
        validatorCustom: ValidatorTemplate.d(),
        keyboardType: TextInputType.text,
        onChanged: (s) async {
          msg_txt = s;

          //ui
          await updateUIAfterInputFieldChange( s );

        }
    );

    return SizedBox( child:  tf, width: getWidthOfFrameTextField() ,);
  }


  double getWidthOfFrameTextField() {
    return DeviceTools.getWidth(context) - buttonSave_frame_widht - frame_width_cameraAndAttachView;
  }


  Decoration getDecorationTextField() {

    //radius in first line only will be 50, after than just radius equal 10
    double radius = 20;
    if( InputMessageState.height_Frame != 50   ) {
      radius = 10;
    }

    return BoarderHelper.rounded( //cardViewShadow
      radiusSize: radius,
       colorBackground: Colors.white,
      colorLine: Colors.grey,
      // widthLine: 0.5
    );
  }



}