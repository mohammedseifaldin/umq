import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/modelTools/ToolsMChatMessage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/ChatMessagePage.dart';
import 'package:umq/modules/chat/presentation/MessagePage/v/views/inputMessage/InputMessageView.dart';
// Import package
// import 'package:record/record.dart';
import 'package:umq/tools/audio/AudioSingleTone.dart';
import 'package:umq/tools/audio/RecorderSoundInstance.dart';
import 'package:umq/tools/laravel/upload/UploadFileLaravelAPI.dart';
import 'package:umq/tools/meta/ToolsMeta.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/time/TimeTools.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';


extension RecordController on InputMessageState {

  //---------------------------------------------------------------------- record start/stop

  Future clickOnRecordIcon() async {
   // Log.i( "clickOnRecordIcon() - isRecorderRun " + isRecorderRun.toString()  ) ;

    // // check permission
    // bool isDenied =  await  RecorderTools.isPermissionDenied(context, true );
    // if( isDenied ) {
    //   return;
    // }

    //stop previous sound
    /**
     * to allow person taking must stop any sound running
     */
    AudioSingleTone.stop();

    //start/pause
    if( isRecorderRun ) {
      await _stopCurrentRecorderSession();
    } else {
      await _createNewRecorderSession();
    }
  }


  Future _createNewRecorderSession() async {

    setState((){
      isRecorderRun = true ;
    });

    //increment
    String keyRecorder = TimeTools.getCurrentTimestamp().toString() + "rec";
    chatMessageState.recorderSoundInstance!.start(context, keyRecorder);
  }


  Future _stopCurrentRecorderSession() async {
    setState((){
      isRecorderRun = false ;
    });

    chatMessageState.recorderSoundInstance!.stop( );

   //validate check size duration of file
    String uri = RecorderSoundInstance.pathDefaultFile;
    bool validRecord = await ToolsMeta.isValidAudioSize(uri );
    if( validRecord == false ) {
      ToolsToast.i(context,  "Very small record duration");
      return;
    }

    //upload
   await uploadingRecord();

  }

  //---------------------------------------------------------------------- upload

  Future uploadingRecord() async {

    //progress
    setState((){
      prg_recorder = true;
    });


    //info
    String filePath = RecorderSoundInstance.pathDefaultFile;
    String urlAPILink = BackendConstant.getUploadFileUrl() ;

    //listener
    await UploadFileLaravelAPI().getDataByFileUrl(urlAPILink: urlAPILink,
        filePath:  filePath ,
        callBack: ( status, msg, responseLaravelUpload ) {


          //progress
          setState((){
            prg_recorder = false;
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
    MChatMessage mMessageNew = ToolsMChatMessage.generateRecorder(
        uploadedUrl,
        chatMessageState.myUserId,
        chatTargetId );

    // api
    await chatMessageState.apiCreateMessage(mMessageNew);
  }




}