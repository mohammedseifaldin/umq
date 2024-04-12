import 'package:audio_session/audio_session.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:umq/tools/File/ToolsFile.dart';

class RecorderSoundInstance {
  RecorderSoundInstance() {
    init();
  }

  //------------------------------------------------------------------------- variable

  static String tag = "recorderSingletone";
  FlutterSoundRecorder? _record;

  //path
  static var pathDefaultFile;
  static String currentRecorderKey = "0"; //key of record id now

  //------------------------------------------------------------------------- type: start/stop

  Future start(BuildContext context, String currentRecorderKey) async {
    //set path key
    RecorderSoundInstance.currentRecorderKey = currentRecorderKey;
    _initPath();

    //code mobile
    Codec codec = Codec.aacMP4;
    if (DeviceTools.isPlatformWeb()) {
      codec = Codec.opusWebM;
    }

    if (DeviceTools.isIOS()) {
      codec = Codec.aacMP4;
    }

    //play current
    try {
      //wait to create temp file
      ToolsWait.waitToDo(100, () async {
        await _record!.startRecorder(
          toFile: pathDefaultFile,
          codec: codec,
          // audioSource: AudioSource.microphone
        );
        Log.k(tag, "start()  - ok  $_record");
      });
    } catch (e) {
      Log.k(tag, "start()  - exc: $e");

      /**
          Exception: Recorder is not open
       */
      await stop();
      // await init();
      return false;
    }
    return true;
  }

  Future stop() async {
    if (_record == null) return;

    /**
        this exception print "Exception: Recorder is not open"
        in case make stop record, while there is not runinig
     */
    if (_record!.isStopped) {
      Log.k(tag, "stop() - isStopped - stop here");
      return;
    }

    try {
      await _record!.stopRecorder();
      // await _record!.closeRecorder();
      Log.k(tag, "stop() - stop ok");
      return;
    } catch (e) {
      Log.k(tag, "stop() - stop old - exc: $e");
    }
  }

  //--------------------------------------------------------------------- listener

  Future addListener() async {
    // _record.
  }

  //---------------------------------------------------------------------- init recorder

  Future init() async {
    await _initPath();

    //open
    ToolsWait.waitToDo(1000, () async {
      _record = await FlutterSoundRecorder().openRecorder();
    });

    await _initAudioConfig();
  }

  Future _initAudioConfig() async {
    //init session
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration(
      avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
      avAudioSessionCategoryOptions:
          AVAudioSessionCategoryOptions.allowBluetooth |
              AVAudioSessionCategoryOptions.defaultToSpeaker,
      avAudioSessionMode: AVAudioSessionMode.spokenAudio,
      avAudioSessionRouteSharingPolicy:
          AVAudioSessionRouteSharingPolicy.defaultPolicy,
      avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
      androidAudioAttributes: const AndroidAudioAttributes(
        contentType: AndroidAudioContentType.speech,
        flags: AndroidAudioFlags.none,
        usage: AndroidAudioUsage.voiceCommunication,
      ),
      androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
      androidWillPauseWhenDucked: true,
    ));
  }

  // static Future _initPath() async  {
  //   String unique = TimeTools.getCurrentTimestamp().toString();
  //   var directory = await getApplicationDocumentsDirectory();
  //   var directoryPath = directory.path;
  //   pathDefaultFile = directoryPath + "/time" + unique + "record.mp4";
  //
  //   //check type web
  //   if( DeviceTools.isPlatformWeb() ) {
  //     pathDefaultFile = directoryPath + "/time" + unique + "record.webm";
  //   }
  //
  //   Log.i( "_initPath() - _mPath: " +  pathDefaultFile );
  // }

  static Future _initPath() async {
    String key = RecorderSoundInstance.currentRecorderKey.toString();

    //check type android
    if (DeviceTools.isAndroid()) {
      var directory = await getApplicationDocumentsDirectory();
      var directoryPath = directory.path;
      RecorderSoundInstance.pathDefaultFile =
          "$directoryPath/myRecorder$key.mp4";
      Log.i("_initPath() - _mPath: " + RecorderSoundInstance.pathDefaultFile);
      return;
    }

    //check type web
    if (DeviceTools.isPlatformWeb()) {
      var directory = await getApplicationDocumentsDirectory();
      var directoryPath = directory.path;
      RecorderSoundInstance.pathDefaultFile =
          "$directoryPath/myRecorder$key.webm";
      Log.i("_initPath() - _mPath: " + RecorderSoundInstance.pathDefaultFile);
      return;
    }

    //check type ios
    if (DeviceTools.isIOS()) {
      var directoryPath = await ToolsFile.getPathDirectory();
      String fullPath = "$directoryPath/myRecorder$key.m4a";
      RecorderSoundInstance.pathDefaultFile = fullPath;
      Log.i("_initPath() - _mPath: ${RecorderSoundInstance.pathDefaultFile}");
      return;
    }
  }
}
