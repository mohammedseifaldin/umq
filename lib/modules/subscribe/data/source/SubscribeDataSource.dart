import 'package:dio/dio.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/constant/AdminConstant.dart';
import 'package:umq/modules/subscribe/data/request/RequestCreateSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/request/RequestSubscribePackageHide.dart';
import 'package:umq/modules/subscribe/data/request/RequestSubscribeUserByAdmin.dart';
import 'package:umq/modules/subscribe/data/request/RequestSubscribeUserByVisa.dart';
import 'package:umq/modules/subscribe/data/response/ResponseArraySubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponsePaginateSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSingleSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSubscribeSingleUser.dart';
import 'package:umq/modules/subscribe/data/response/ResponseSubscribeUsers.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/EndPoint.dart';

class SubscribeDataSource {

  //------------------------------------------------------------------------ create / edit package

  static Future<ResponseSingleSubscribePackage?> editPackage(RequestCreateSubscribePackage request ) async {
    String url = EndPoint.subscribePackageCreate +"/" + request.editObjectId.toString();
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().put(url, body: request.toJson(), headers: headers );
    try {
      return ResponseSingleSubscribePackage.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }

  static Future<ResponseSingleSubscribePackage?> createPackage(RequestCreateSubscribePackage request ) async {
    String url = EndPoint.subscribePackageCreate;
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().post(url, body: request.toJson(), headers: headers );
    try {
      return ResponseSingleSubscribePackage.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }

  //------------------------------------------------------------------------ get list package

  static Future<ResponsePaginateSubscribePackage?> getListPackageWithPaginate(int page ) async {
    String url = EndPoint.subscribePackageGetWithPaginate + "?page=$page&paginator=${AdminConstant.limitItemList}";
    Response responseDio = await NetworkManagerDio().get(url , isEnableLogDioPretty: false);
    try {
      return ResponsePaginateSubscribePackage.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }


  static Future<ResponseArraySubscribePackage?> getAllListPackage(  ) async {
    String url = EndPoint.subscribePackageGetAll ;
    Response responseDio = await NetworkManagerDio().get(url );
    try {
      return ResponseArraySubscribePackage.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }

  //------------------------------------------------------------------------ hide package

  static Future<ResponseSingleSubscribePackage?> hidePackage( RequestSubscribePackageHide request) async {
    String url = EndPoint.subscribePackageHide + "/${request.packageId}";
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().put(url, headers : headers, body: request.toJson() );
    try {
      return ResponseSingleSubscribePackage.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }

  //------------------------------------------------------------------------ users

  static Future<ResponseSubscribeUsers?> getListUsersWithPaginate(int page ) async {
    String url = EndPoint.subscribeUsersGetWithPaginate + "?page=$page&paginator=${AdminConstant.limitItemList}";
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().get(url , headers: headers,  isEnableLogDioPretty: true);
    try {
      return ResponseSubscribeUsers.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }


  static Future<ResponseSubscribeSingleUser?> createUserByAdmin( RequestSubscribeUserByAdmin request ) async {
    String url = EndPoint.subscribeUsersCreate;
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().post(url, body: request.toJson(), headers: headers );
    try {
      return ResponseSubscribeSingleUser.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }


  static Future<ResponseSubscribeSingleUser?> createUserByVisa( RequestSubscribeUserByVisa request ) async {
    String url = EndPoint.subscribeUsersCreate;
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().post(url, body: request.toJson(), headers: headers );
    try {
      return ResponseSubscribeSingleUser.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }


  static Future<ResponseSubscribeSingleUser?> currentSubscribe(   ) async {
    String url = EndPoint.subscribeUsersGetCurrentSubscribe;
    String token = await UserSingleTone.instance().getToken();
    Map<String, String> headers = NetworkHeaderTools.bearerToken( token );
    Response responseDio = await NetworkManagerDio().get(url, headers: headers );
    try {
      return ResponseSubscribeSingleUser.fromJson( responseDio.data);
    } catch (e) {
      Log.i("general_message - error: $e");
      return null;
    }
  }


}