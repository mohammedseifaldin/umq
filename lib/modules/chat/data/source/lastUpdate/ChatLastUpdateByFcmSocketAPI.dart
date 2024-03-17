import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/response/ResponseUserList.dart';

import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/place/data/response/ResponseListCity.dart';

import 'package:umq/modules/chat/data/response/lastUpdate/ResponseChatLastUpdate.dart';

import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/values/ToolsValue.dart';

typedef ChatLastUpdateAPICallBack = Function(
    bool status, String msg, ResponseChatLastUpdate response);

class ChatLastUpdateByFcmSocketAPI {
  //user_limit=30&message_target_userid=16&message_greater_than_id=26
  int? user_limit = 0;
  int? fcm_sender_id = 0;
  int? message_greater_than_id =
      0; //userId another person need to get latest message
  late ChatLastUpdateAPICallBack callBack;

  //data
  ResponseChatLastUpdate response = ResponseChatLastUpdate();

  Future getData(
      {required int user_limit,
      required int fcm_sender_id,
      required int message_greater_than_id,
      required ChatLastUpdateAPICallBack callBack}) async {
    this.user_limit = user_limit;
    this.fcm_sender_id = fcm_sender_id;
    this.message_greater_than_id = message_greater_than_id;
    this.callBack = callBack;

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //url
    String url =
        BackendConstant.baseUrlv2 + "/ChatBoth/getLastUpdateWithSpecificUser?";
    url += "user_limit=" + user_limit.toString();
    url += "&message_target_userid=" + fcm_sender_id.toString();
    url += "&message_greater_than_id=" + message_greater_than_id.toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //webservice
    NetworkManagerDio().callBack(url,
        headers: header,
        type: NetworkTypeDio.post, callback: (status, msg, json) {
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

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("exe: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
