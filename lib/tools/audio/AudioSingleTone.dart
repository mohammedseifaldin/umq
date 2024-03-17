import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/toolsUI/Widgets/button_primary_widget.dart';


typedef CallBackDuration = Function(bool isPlaying, Duration updateDuration );
typedef CallBackRecorderStatus = Function(   bool isPlaying );


class AudioSingleTone {

  //------------------------------------------------------------------ variable

  static String tag = "AudioSingleTone";
  static var  _assetsAudioPlayer = AssetsAudioPlayer.newPlayer();
  static bool isPlaying = false;
  static String lastPlayed = "";

  //------------------------------------------------------------------ play type network

  /**
   link example:   //"http://www.mysite.com/myMp3file.mp3"
   */
  static Future<bool> playLink( String link) async {
    Log.k(tag, "playLink()  - link: " + link.toString());

    AudioSingleTone.lastPlayed = link;

    //stop previous
    await stop();

    //play current
    try {
      var audio = Audio.network( link );
      _assetsAudioPlayer.open(audio  );

      Log.k(tag, "playLink()  - ok  " );
    } catch (e) {
      Log.k(tag, "playLink()  - exc: " + e.toString());
      //mp3 unreachable
      return false;
    }

    return true;
    //assetsAudioPlayer.play();
  }

  //------------------------------------------------------------------ play asset

  /**
   * path exmaple:  "assets/audios/song1.mp3"
   */
  static Future<bool> playAsset(String path) async {
    Log.k(tag, "playAsset()  - path: " + path.toString());
    AudioSingleTone.lastPlayed = path;

    //stop previous
    await stop();

    //play current
    try {
      _assetsAudioPlayer.open(Audio(path), autoStart: true, forceOpen: true  );

      // //listener
      // _assetsAudioPlayer.current.listen((playing){
      //   // final path = playing!.sound.assetAudioPath;
      //   final songDuration = playing!.audio.duration;
      //   // Log.k(tag, "playAsset()  - songDuration: " + songDuration.toString());
      // });

      //   _assetsAudioPlayer.play();
      Log.k(tag, "playAsset()  - ok  " );
    } catch (e) {
      Log.k(tag, "playAsset()  - exc: " + e.toString());
      //mp3 unreachable
      return false;
    }

    return true;
    //assetsAudioPlayer.play();
  }

  //---------------------------------------------------------------- play type: file uri


  static Future playFromFileUri(String fileUri ) async {
    //stop previous
    await stop();

    _assetsAudioPlayer.open(
      Audio.file(fileUri),
    );

    Log.k(tag, "playFromFileUri()  - ok  " );

  }
  //------------------------------------------------------------------ listener

  static void addListenerDuration(CallBackDuration callBackDuration)  {

    //listener playing
    _assetsAudioPlayer.isPlaying.listen((event) {
      isPlaying = event;
    });

    //listener duration
    _assetsAudioPlayer.realtimePlayingInfos.listen(( realtimePlayingInfos) {

      Duration currentDuration = realtimePlayingInfos.currentPosition;
      // Log.k(tag, "playLink() - realtimePlayingInfos - currentDuration: " + currentDuration.toString());
      // Log.k(tag, "playLink() - realtimePlayingInfos - isPlaying: " + isPlaying.toString());
      callBackDuration( isPlaying, currentDuration);
    });

  }


  static Future addListenerRecorderStatus( String link,  CallBackRecorderStatus callback)  async {

    //listener playing
    _assetsAudioPlayer.isPlaying.listen((event) {

      //set result
      isPlaying = event;
      Log.i( "addListenerRecorderStatus() - isPlaying: " + event.toString() );

      //valdite
      /**
       * fix when listener working click play to one recorder message, all message
       * change status at same time
       */
      bool notSameLinkAudio = AudioSingleTone.lastPlayed != link;
      if( notSameLinkAudio ) {
        Log.i( "addListenerRecorderStatus() - notSameLinkAudio => stop !");
        return;
      }

      //callback
      callback(isPlaying);
    });
  }


  //---------------------------------------------------------------- stop methods

  static Future<bool>  stop() async {
 //   Log.k(tag, "playAsset() - stop  _assetsAudioPlayer " + _assetsAudioPlayer.toString()  );
    try {
      if( _assetsAudioPlayer == null ) {
        Log.k(tag, "stop() - _assetsAudioPlayer == null - stop!"  );
        return false ;
      }
      if( isPlaying == false ) {
        Log.k(tag, "stop() - isPlaying == false - stop!"  );
        return false;
      }

      _assetsAudioPlayer.stop();
   //   _assetsAudioPlayer.dispose();
      Log.k(tag, "stop() - stop  ok"  );
    } catch (e) {
      Log.k(tag, "stop() - stop old - exc: " + e.toString());
    }

    return true;
  }

  //------------------------------------------------------------------------- fix error
  /**
      "flutter" Error: NotAllowedError: play() failed because the mobile didn't interact with the document firs
   */

  static bool _isFixUserInteractBefore = false;


  static Future<bool> fixUserDidNotInteract(String pathAsset ) async{
    if(_isFixUserInteractBefore == false ) {
      _isFixUserInteractBefore = true;
      return playAsset(pathAsset);
    }
    return false;
  }


}
