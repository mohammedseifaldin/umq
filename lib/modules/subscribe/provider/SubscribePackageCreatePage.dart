import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/subscribe/data/request/RequestCreateSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSingleSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/source/SubscribeDataSource.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension SubscribePackageCreate on SubscribeChangeNotifier {


  //-------------------------------------------------------------------------- create package


  Future createOrEditPackage(BuildContext context, RequestCreateSubscribePackage request  ) async  {

    _createPackageUpdateProgress( true );

    if(_validateCreatePackageWithPrintToast(context, request) == false )return;

    ResponseSingleSubscribePackage? response;
    if( request.editObjectId != null ) {
      //api
      response  = await   SubscribeDataSource.editPackage( request);
    } else {
      response  = await   SubscribeDataSource.createPackage( request);
    }

    _createPackageUpdateProgress( false );

    if( response == null ) {
      return;
    }

    if( response.data != null ) {
      _successCreatePackage( context );
    }
    return response;
  }


  bool _validateCreatePackageWithPrintToast(BuildContext context, RequestCreateSubscribePackage request ){

    //name en
    if( ToolsValidation.isName(request.nameEn) == false ) {
      ToolsToast.i(context,  "Name En Missed");
      return false ;
    }

    //name ar
    if( ToolsValidation.isName(request.nameAr) == false ) {
      ToolsToast.i(context,  "Name Ar Missed");
      return false ;
    }

    //desc en
    if( ToolsValidation.isName(request.descriptionEn) == false ) {
      ToolsToast.i(context,  "Description En Missed");
      return false ;
    }

    //desc ar
    if( ToolsValidation.isName(request.descriptionAr) == false ) {
      ToolsToast.i(context,  "Description Ar Missed");
      return false ;
    }

    //price
    if( ToolsValidation.isZeroInt(request.price)   ) {
      ToolsToast.i(context,  "Price Missed");
      return false ;
    }

    //period
    if( ToolsValidation.isZeroInt(request.period)  ) {
      ToolsToast.i(context,  "Period Missed");
      return false ;
    }

    //allowedProductNumbers
    if( ToolsValidation.isZeroInt(request.allowedProductNumbers)  ) {
      ToolsToast.i(context,  "Allowed Product Numbers Missed");
      return false ;
    }

    //allowedChat
    if( request.allowedChat == null ) {
      ToolsToast.i(context,  "Allowed Chat Missed");
      return false ;
    }
    return true;
  }


  void _createPackageUpdateProgress(bool update  ) {
    createPackageProgressStatus = update;
    notifyListeners();
  }


  void _successCreatePackage(BuildContext context){
    ToolsToast.i(context,  "Success");
    ToolsWait.waitToDo(1000, () => Navigator.pop(context) );
  }

}