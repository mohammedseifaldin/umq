import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/message/NewMessageSingleTone.dart';
import 'package:umq/modules/chat/shared/toolsChat/singletone/socketContinue/SocketContinueDownloadData.dart';
import 'package:umq/tools/time/TimeTools.dart';

class SocketContinueController  {

  //options of infinity
  /**
   *- when increase the miliescond time, cause the speed of chat is slow, while
   *  decrease resources of "Ram" and "interent"
   *
   - if you make time  "infinityLoopDuration = 50" means loop 20 times per second
      means in 1 minute need to loop 1200 second call the server, this will effect
      the server "Too Many Request 429" error

   - to avoid this just make "infinityLoopDuration = 500" means loop 2 times per second
      means max is 120 request per 1 minute
   */
  static int infinityLoopDuration  = 500; //for live 500  //for test wait 7 second 7000


  //controller of timers
  static Timer? myTimer;

  //times
  static int messageIdQueryGreaterThan = 0; //query send to get greater than this id message
  static int timePreviousRun = 0 ; // the time of previous fire timer

  /**
   * 0 : means not start
   * 1 : still loading data not completed yet
   * 2 : means complete downloa
   */
  static int statusProcessId = 0;

  //log
  static int counterDownloadCompleted = 0;
  static int counterTimerFire = 0;

  //fix time zone
  static String?  countryCode;

  Future start() async {

    countryCode = await ZoneTools.getZoneCountryDialCode(  "+20"  );
    Log.i( "SocketContinueController - start() - messageIdQueryGreaterThan: " +  messageIdQueryGreaterThan.toString()
        + " /countryCode: " + countryCode.toString()  );

    //loop infinity
    await _infinityTimerStart();
  }


  void stop() {
    if( myTimer == null ) return;
    myTimer!.cancel();
  }


  Future _infinityTimerStart() async {
    myTimer = Timer.periodic(Duration(milliseconds: infinityLoopDuration ), (_) {

      //log
      counterTimerFire = counterTimerFire + 1;
     // Log.i("_infinityTimerStart() - call " + counterTimerFire.toString()  );

      _validateStartDownload();
    });
  }


  Future _validateStartDownload() async {
    //case: already waiting
    bool isWaiting = statusProcessId == 1;
    if( isWaiting ) {
     //Log.i("_validateStartDownload() - isWaiting - stop !"   );
      return;
    }

    //case: complete
    bool isComplete = statusProcessId == 2;
    if( isComplete ) {
      await _fireDownload();
      return;
    }

    //case: first time
    bool isNotStartBefore = statusProcessId == 0;
    if( isNotStartBefore ) {
      await _fireDownload();
      return;
    }
  }


  Future _fireDownload() async {
      //Log.i("_fireDownload() - counterTimerFire: $counterTimerFire"   );

      //time
       timePreviousRun = TimeTools.getCurrentTimestamp();

      //api
      SocketContinueDownloadData.apiSocketContinue();
  }


}