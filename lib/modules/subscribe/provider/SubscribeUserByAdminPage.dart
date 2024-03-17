import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/modules/subscribe/data/request/RequestSubscribeUserByAdmin.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSingleSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSubscribeSingleUser.dart';
import 'package:umq/modules/subscribe/data/source/SubscribeDataSource.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';
import 'package:umq/toolsUI/dialog/MessageGeneralDialog.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension SubscribeUserByAdminPage on SubscribeChangeNotifier {


  //-------------------------------------------------------------------------- download package all

  Future downloadSubscribePackageAllData(BuildContext context ) async {
    _updateProgress( true );

    allSubscribePackage = await   SubscribeDataSource.getAllListPackage();

    _updateProgress( false );
  }

  //-------------------------------------------------------------------------- create subscribe


  Future createSubscribeUserByAdmin(BuildContext context, RequestSubscribeUserByAdmin request  ) async  {

    _updateProgress( true );

    if(_validatecreateSubscribeUserByAdminWithPrintToast(context, request) == false )return;

    ResponseSubscribeSingleUser? response = await   SubscribeDataSource.createUserByAdmin( request);
    Log.i("createSubscribeUserByAdmin() - response done - $response");
    _updateProgress( false );

    if( response == null ) {
      return;
    }

    if( response.data != null ) {
      _successCreateSubscribe(context);
    } else {
      _failedPrintMessage( context ,response.message??"Failed");
    }
    return response;
  }


  bool _validatecreateSubscribeUserByAdminWithPrintToast(BuildContext context, RequestSubscribeUserByAdmin request ){

    //user
    if( ToolsValidation.isEmpty(request.userId)  ) {
      ToolsToast.i(context,  "Select Username");
      return false ;
    }

    //package
    if( ToolsValidation.isEmpty(request.packageId) ) {
      ToolsToast.i(context,  "Select Package");
      return false ;
    }
    return true;
  }


  void _updateProgress(bool update  ) {
    subscribeUserByAdminProgressStatus = update;
    notifyListeners();
  }


  void _successCreateSubscribe(BuildContext context){
    Log.i("_successCreateSubscribe() - ");
    ToolsToast.i(context,  "Success");
    ToolsWait.waitToDo(1000, () => Navigator.pop(context) );
  }

  void _failedPrintMessage(BuildContext context, String msg ) {
    Log.i("_failedPrintMessage() - msg: $msg");
    MessageGeneralDialog.infoNoAction(context, "Subscribe Failed", msg, (isClickOnYes) => null);
  }

}