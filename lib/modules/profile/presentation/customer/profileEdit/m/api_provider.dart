import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/main.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/m/edit_model.dart';
import 'package:umq/tools/data/dynamic/ResponseGeneralDynamic.dart';
import 'package:umq/tools/cache/user_single_tone.dart';

class ApiProvider {

  static Duration durationTimeout = const Duration(seconds: 30);


  static Future<ResponseGeneralDynamic> _postRequest(url, body) async {
    final Map<String, String> headers = await _header(true);
    if (kDebugMode) {
      print(url);
      print(headers);
      print(body);
    }
    try {
      http.Response response = await http
          .post(
            Uri.parse(url),
            headers: headers,
            body: json.encode(body),
          )
          .timeout(durationTimeout);

      return _result(response);
    } on TimeoutException catch (_) {
      return ResponseGeneralDynamic(
        isSuccess: false,
        status: -1,
        result: "Internet error",
      );
    } on SocketException catch (_) {
      return ResponseGeneralDynamic(
        isSuccess: false,
        status: -1,
        result: "Internet error",
      );
    }
  }

  static Future<ResponseGeneralDynamic> _getRequest(url) async {
    final Map<String, String> headers = await _header(true);
    if (kDebugMode) {
      print(url);
      print(headers);
    }
    try {
      http.Response response = await http
          .get(
            Uri.parse(url),
            headers: headers,
          )
          .timeout(durationTimeout);
      return _result(response);
    } on TimeoutException catch (_) {
      return ResponseGeneralDynamic(
        isSuccess: false,
        status: -1,
        result: "Internet error",
      );
    } on SocketException catch (_) {
      return ResponseGeneralDynamic(
        isSuccess: false,
        status: -1,
        result: "Internet error",
      );
    }
  }

  static ResponseGeneralDynamic _result(http.Response response) {
    if (kDebugMode) {
      print(response.body);
      print(response.statusCode);
    }
    int status = response.statusCode;
    if (response.statusCode >= 200 && response.statusCode <= 299) {
      return ResponseGeneralDynamic(
        isSuccess: true,
        status: status,
        result: json.decode(utf8.decode(response.bodyBytes)),
      );
    } else if (response.statusCode == 500 || response.statusCode == 404) {
      return ResponseGeneralDynamic(
        isSuccess: false,
        status: status,
        result: "Server error",
      );
    } else {
      try {
        var result = json.decode(utf8.decode(response.bodyBytes));
        return ResponseGeneralDynamic(
          isSuccess: false,
          status: status,
          result: result,
        );
      } catch (_) {
        return ResponseGeneralDynamic(
          isSuccess: false,
          status: status,
          result: "Server error",
        );
      }
    }
  }

  static Future<Map<String, String>> _header(bool k) async {

    String token  = await UserSingleTone.instance().getToken();

    if (!k) {
      return {
        "Authorization":
            "Bearer $token"
      };
    } else {
      return {
        "Accept": "application/json",
        'content-type': 'application/json; charset=utf-8',
        "Authorization":
            "Bearer $token"
      };
    }
  }

  Future<ResponseGeneralDynamic> edit(EditProfileRequest data, int userId) async {
    return _postRequest(
      BackendConstant.domain + "/public/api/v2/auth/user/updateData",
      data,
    );
  }

  Future<ResponseGeneralDynamic> getCountry() async {
    return _getRequest(
      BackendConstant.domain  + "/public/api/v1/city/?page=1&paginator=100",
    );
  }
}
