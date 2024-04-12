import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

abstract class ManageContext {
  //implements IManageContext

  //------------------------------------------------------------------- variable

  static BuildContext? _context;
  static final List<BuildContext> _listContext = [];

  //------------------------------------------------------------------- public method

  static BuildContext getContext() {
    return _context!;
  }

  static setContext(BuildContext ctx) {
    //set current
    _context = ctx;

    //appened
    _listContext.add(ctx);
  }

  //---------------------------------------------------------------------- finish

  /**
      for loop all previous "GoTo" pages and make finish it by Navigaor.pop()"
   */
  static finishLastPage() {
    /**
     * log backend
     */
    for (var e in _listContext) {
      Log.i("logAllPages() - _listContext - loop $e");
    }

    //kill last
    if (_listContext.isNotEmpty) {
      BuildContext last = _listContext.last;
      Log.i("logAllPages() - last $last");
      Navigator.of(last).pop();
    }
  }
}
