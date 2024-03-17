import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class SoundSingleTone {

  static FlutterSoundPlayer _mPlayer = FlutterSoundPlayer();
  static bool _isInitilized = false;

  static Future playFromUri(BuildContext context, String pathUri ) async {

    //check initlized
    if( _isInitilized == false ) {
      ToolsToast.i(context,  "Must call method init() inside initState()");
      return;
    }


    Log.i( "playFromUri() - _mPlayer " + _mPlayer.toString() ) ;

    await _mPlayer.startPlayer(
        fromURI: pathUri,
        //codec: kIsWeb ? Codec.opusWebM : Codec.aacADTS,
        whenFinished: () {
         Log.i( "playFromUri() - whenFinished");
        });

    Log.i( "playFromUri() - ok "  ) ;
  }

  static Future stop() async {
    _mPlayer.closePlayer();
  }

  //----------------------------------------------------------------- init


  static Future init() async {
    await _mPlayer.openPlayer().then((value) {
      Log.i( "SoundSingleTone - init() - value " + value.toString() ) ;
      _isInitilized = true;
    });
  }


}