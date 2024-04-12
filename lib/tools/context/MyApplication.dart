import 'package:fastor_app_ui_widget/resource/toolsFastor/device/deviceChangeSize/DeviceSizeChangeBase.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';

import 'ManageContext.dart';
import 'ManageWidget.dart';
// import 'dart:ffi';

class MyApplication {
  //------------------------------------------------------------------- public : context

  static void finishLastPage() {
    ManageContext.finishLastPage();
  }

  static BuildContext getContext() {
    return ManageContext.getContext();
  }

  static void setContext(BuildContext ctx) {
    ManageContext.setContext(ctx);
    DeviceSizeChangeBase.updateListenerChangeSize(ctx);
  }

  //---------------------------------------------------------------------- public: widget

  static setWidget_StatelessWidget(Widget w) {
    ManageWidget.setWidget_StatelessWidget(w);
  }

  static setWidget_ResumableState(ResumableState resume) {
    ManageWidget.setWidget_ResumableState(resume);
  }
}
