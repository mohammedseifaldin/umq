import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:umq/tools/Dios/common_constant.dart';
import 'package:umq/toolsUI/dialog/snack_bar_message.dart';
import 'package:umq/toolsUI/progress/lock_overlay/lock_overlay.dart';



GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();


BaseOptions options = new BaseOptions(
  baseUrl: CommonConstant.baseURL,
  connectTimeout: Duration(milliseconds:60000  ) ,
  receiveTimeout:Duration(milliseconds:60000  ) ,
  maxRedirects: 0,
);

var _freshDio = new Dio(options);
bool isLoading=false;
Dio httpClient()  {
  _freshDio.interceptors.add(PrettyDioLogger(
    requestHeader: !kReleaseMode,
    requestBody: !kReleaseMode,
    responseBody: !kReleaseMode,
  ));

  _freshDio.interceptors.add(HeaderInterceptor());
  return _freshDio;
}
Dio httpClientWithHeader(token)  {
  isLoading=true;
  _freshDio.options.headers['content-Type'] = 'application/json';
  _freshDio.options.headers["authorization"] = "bearer $token";
  _freshDio.interceptors.add(PrettyDioLogger(
    requestHeader: !kReleaseMode,
    requestBody: !kReleaseMode,
    responseBody: !kReleaseMode,
  ));
  _freshDio.interceptors.add(HeaderInterceptor());
  return _freshDio;
}

class HeaderInterceptor extends Interceptor {

  @override
  void onRequest(RequestOptions options,RequestInterceptorHandler handler) async {
    isLoading=true;
    return super.onRequest(options,handler);

  }



  @override
  void onResponse(Response response,ResponseInterceptorHandler handler) {
    _freshDio.interceptors.clear();
    return super.onResponse(response,handler);
  }

  @override
  void onError(DioError err,ErrorInterceptorHandler handler) {
    _freshDio.interceptors.clear();
    if(isLoading) {
      isLoading=false;
      SnackBarHelper.ShowErrorMessage( navigatorKey.currentContext,
          "${err.response!.data['message']}");
      LockOverlay().closeOverlay();
    }
    return super.onError(err,handler);

  }
}
