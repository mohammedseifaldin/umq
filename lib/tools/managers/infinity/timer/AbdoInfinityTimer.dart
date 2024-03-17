import 'dart:async';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

typedef AbdoInfinityCallBack = Function( bool cancel, int counterLooper );

class AbdoInfinityTimerManager {

  static String tag = "AbdoInfinityTimerManager";


  //constructor
  AbdoInfinityCallBack _callBack;
  late int _millisecondsInfinity  ;

  //data
  bool isPause = false ;
  int _counterLooper = 0;
  bool _isCanceled = false;


  AbdoInfinityTimerManager( this._callBack, { int? milliseconds }  ) {

    //set milisecond
    milliseconds ??= 1000;
    _millisecondsInfinity = milliseconds;
  }

  //------------------------------------------------------------------ public

  // bool isStatusRunning() { return !}

  void cancel() {
    _isCanceled = true;
  }

  void pause(){
    isPause = true;
  }

  void resume(){
    isPause = false;
  }

  void start() {
    //start first one now
    _validte();

    //handler
    _timerInfinity();
  }
  //------------------------------------------------------------------ private

  late Timer timer;

  _timerInfinity(){
    timer = Timer.periodic(Duration(milliseconds: _millisecondsInfinity ), (_) {

      _validte();

    });
  }

  void _validte() {
    //increment
    _counterLooper = _counterLooper + 1 ;
    Log.k(tag,"_timerInfinity() - counterLooper: " + _counterLooper.toString()  );

    //check need to distory the timer
    if( _isCanceled ) {
      Log.k(tag,"_timerInfinity() - isCanceled - stop! "   );
      timer.cancel();
      return;
    }

    //check progress still waiting
    if( isPause ) {
      Log.k(tag,"_timerInfinity() - isPause - stop! "   );
      return;
    }

    //call back
    _callBack(_isCanceled, _counterLooper );
  }



}