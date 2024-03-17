import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:media_info/media_info.dart';

class ToolsMeta {

  static String tag = "ToolsMeta";


  /**
   see https://stackoverflow.com/a/72411754/7186671
      exmaple 2666  means more than 2 second
      the value return is milisecond
   */
  static Future getDurationAudio(String pathUri ) async {
    Map<String, dynamic> infoMap = await getInfoMediaFile(pathUri);//"your/media/file"
    return infoMap["durationMs"];
  }

  //example android uri: /data/user/0/com.scubaksa.scuba/app_flutter/myRecorder0.mp4
  //example ios uri: '/var/mobile/Containers/Data/Application/0303FEAB-87F4-4FC2-9993-BC5CEAC8AA76/Documents/myRecorder1656196344rec.mp4'
  //example result: () - infoMap: {bitrate: -1, mimeType: audio/mp4a-latm, durationMs: 2688}
  static Future<Map<String, dynamic> > getInfoMediaFile(String pathUri ) async {
    Log.i( "getInfoMediaFile() - pathUri: " + pathUri.toString() );
    final MediaInfo _mediaInfo = MediaInfo();
    Map<String, dynamic> infoMap = await _mediaInfo.getMediaInfo( pathUri );//"your/media/file"
    Log.i( "getInfoMediaFile() - infoMap: " + infoMap.toString() );
    return infoMap;
  }

  /**
   * check the duration of file is valied, means more than 1 second
   */
  static Future<bool> isValidAudioSize( String pathUri ) async {
    //ios check
    /**
     crash at
        [VERBOSE-2:ui_dart_state.cc(198)] Unhandled Exception: FileSystemException: Cannot open file, path = '/var/mobile/Containers/Data/Application/B2DABC5B-A5CC-4452-9902-D0BFF7561CB5/Documents/myRecorder1656182478rec.mp4'
        (OS Error: No such file or directory, errno = 2)
        #0      _File.throwIfError (dart:io/file_impl.dart:635:7)
        #1      _File.openSync (dart:io/file_impl.dart:479:5)
     */
    if( DeviceTools.isIOS() ) return true;

    //android check
    int durcation = await getDurationAudio(pathUri);
    bool isMoreThan1Second = durcation >= 1000;
    Log.i( "isValidAudioSize() - durcation: " + durcation.toString() );
    Log.i( "isValidAudioSize() - isMoreThan1Second: " + isMoreThan1Second.toString() );
    return isMoreThan1Second;
  }

}