import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
import 'package:umq/tools/attachCapture/capture/CaptureTools.dart';
import 'package:umq/tools/laravel/upload/UploadFileLaravelAPI.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension ChatImageInputController on InputMessageState {


  //------------------------------------------------------------------- camera

  Future captureClick() async {
    Log.i("captureClick()");

    //picker photo
    await _listenerPickerCapture();

  }


  Future _listenerPickerCapture() async {
    //step : picker
    await CaptureTools.typeCaptureOnly( DrawableProject.placeholderImage,
            (status, msg, filePath, image, unitFile) async {

          //check failed picked
          if( status == false ) {
            //return failed
            ToolsToast.i(context, msg);
            return;
          }

          //progress
          setState((){
            prg_capture = true;
          });

          //step : upload
          await _apiUploadFile(  filePath  );

        });

  }

  /**
   * upload file to generate url
   */
  Future _apiUploadFile(String filePath) async {

    //listener
    String urlApiLink = BackendConstant.getUploadFileUrl()  ;
    await UploadFileLaravelAPI().getDataByFileUrl(urlAPILink: urlApiLink,
        filePath:   filePath ,
        callBack: ( status, msg, responseLaravelUpload ) {

          //progress
          setState((){
            prg_capture = false;
          });

          //check failed
          if( status == false ) {
            ToolsToast.i(context, msg);
            return;
          }

          //success
          String uploadedUrl = responseLaravelUpload.data!.path!;
          _createMessageFile( uploadedUrl  );

        });
  }


  Future _createMessageFile(String uploadedUrl) async {

    // create message
    MChatMessage mMessageNew = ToolsMChatMessage.generateFile(
        uploadedUrl,
        chatMessageState.myUserId,
        chatTargetId );


    //update ui before api
    //await clearInputView();
    // await updateUIAfterInputFieldChange( "");
    //   await ToolsKeyboard.dismiss( chatMessageState.context);
    // await chatMessageState.addNewMessageCreated( mMessageNew );

    // api
    await chatMessageState.apiCreateMessage(mMessageNew);
  }
}