import 'package:flutter/material.dart';

class LifeCycleSingletone {

  static State? _userListPage ;
  static State? _messagePage ;
  // static bool _isChatAllPagesInActive = true;

  //---------------------------------------------------------------------- single tone

  LifeCycleSingletone._();

  //2- make one time sync
  static bool _isSync = false;

  //3- return instance
  static LifeCycleSingletone instance(){
    if( _isSync == false ) {
      _isSync = true;
      _startSingletoneInitlize();
    }
    return LifeCycleSingletone._();
  }

  //----------------------------------------------------------- initilize

  static _startSingletoneInitlize() {
    _userListPage = null;
    _messagePage = null;
    // _isChatAllPagesInActive = true;
  }

  //-------------------------------------------------------------- setter/getter

  void setChatListPage(State stateClass ) {
    _userListPage = stateClass;
  }


  bool getChatListPage() {
    if( _userListPage == null ) return false;
    return _userListPage!.mounted ;
  }


  void setChatMessagePage(State stateClass ) {
    _messagePage = stateClass;
  }

  bool getChatMessagePage() {
    if( _messagePage == null ) return false;
    return _messagePage!.mounted ;
  }

}