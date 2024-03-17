//
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/response/ResponseUserList.dart';

import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/place/data/response/ResponseListCity.dart';

import 'package:umq/modules/chat/data/response/lastUpdate/ResponseChatLastUpdate.dart';
import 'package:umq/modules/chat/data/response/userChatList/ResponseChatUserList.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/values/ToolsValue.dart';

typedef ChatChatSocketContinueAPICallBack = Function(
    bool status, String msg, ResponseChatLastUpdate response);

class ChatSocketContinueAPI {
  int? user_limit = 0;
  int? index_loop = 0;
  int? message_greater_than_time = 0;
  String? countryCode;
  late ChatChatSocketContinueAPICallBack callBack;

  //data
  ResponseChatLastUpdate response = ResponseChatLastUpdate();

  Future getData(
      {required int user_limit,
      required int message_greater_than_time,
      required int index_loop,
      required String countryCode,
      required ChatChatSocketContinueAPICallBack callBack}) async {
    this.user_limit = user_limit;
    this.message_greater_than_time = message_greater_than_time;
    this.index_loop = index_loop;
    this.countryCode = countryCode;
    this.callBack = callBack;
    // Log.i("getData() "   );

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //url
    String url = BackendConstant.baseUrlv2 + "/ChatBoth/getSocketContinue?";
    url += "user_limit=" + user_limit.toString();
    url += "&message_greater_than_id=" + message_greater_than_time.toString();
    url += "&index_loop=" + index_loop.toString();
    url += "&country_code=" + countryCode.toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //webservice
    NetworkManagerDio().callBack(url,
        isEnableLogDioPretty: false, //EnvironmentConstant.isTest,
        headers: header,
        type: NetworkTypeDio.post, callback: (status, msg, json) {
      //log
      // Log.i( "_startAPI()  - url: " + url.toString() );
      // Log.i( "_startAPI()  - json: " + json.toString() );
      // Log.i( "_startAPI()  - status: " + json.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(false, msg, response);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      response = ResponseChatLastUpdate().fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, "Failed to download", response);
        return;
      }

      //check have data
      if (response.data == null) {
        callBack(false, "Failed to download data", response);
        return;
      }

      //log in success found data
      //  Log.i( "ChatSocketContinueAPI - Success: " + mapJson.toString() );

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("exe: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
