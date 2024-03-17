import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';

import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/constant/ConstantProject.dart';

import 'package:http/http.dart' as http;
import 'package:umq/toolsUI/app_constants.dart';

import '../response/ResponseHomePage.dart';

typedef CallbackHomeAPI = Function(
    bool status, String msg, ResponseHomePage response);

class HomeApi {
  BuildContext context;
  int page;
  CallbackHomeAPI callback;

  HomeApi(this.context, this.page, this.callback) {
    _start();
  }

  //this api retun home page , with paginate providers
  void _start() async {
    //url
    String paginator = ConstantProject.paginator.toString();
    String url =
        '${ApiConstants.endPoint_v2_public}/home?page=$page&paginator=$paginator';

    //header
    var token = UserSingleTone.instance().getToken();
    Map<String, String> headerMe = NetworkHeaderTools.bearerToken(token);

    //load
    await NetworkManagerDio().callBack(url,
        isEnableLogDioPretty: false,
        headers: headerMe, callback: (status, msg, response) {
      //    Log.i( "getHomePageWithPaginateProviders() - response: " + response.toString() );
      //
      if (status == false) {
        callback(status, "Refresh the Page", ResponseHomePage());

        return;
      }

      parseHomeApi(response);
    });
  }

  void parseHomeApi(Map<String, dynamic> mapJson) {
    try {
      //parse
      var responseHomePage = ResponseHomePage.fromJson(mapJson);
      // Log.i( "parseHomeApi() - response: " + responseHomePage.toString() );
      // Log.i( "parseHomeApi() - callBackApiHome: " + callback.toString() );

      //callback success
      if (callback != null) {
        callback(true, "success", responseHomePage);
      } else {
        Log.i("parseHomeApi() - exc - callback is null: ");
      }
    } catch (e) {
      Log.i("parseHomeApi() - exc - e: $e");
    }
  }
}
