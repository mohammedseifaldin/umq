import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/response/lastUpdate/ResponseChatLastUpdate.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ChatLastUpdateAPICallBack = Function(
    bool status, String msg, ResponseChatLastUpdate response);

class ChatLastUpdateByFcmSocketAPI {
  //user_limit=30&message_target_userid=16&message_greater_than_id=26
  int? userLimit = 0;
  int? fcmSenderId = 0;
  int? messageGreaterThanId =
      0; //userId another person need to get latest message
  late ChatLastUpdateAPICallBack callBack;

  //data
  ResponseChatLastUpdate response = ResponseChatLastUpdate();

  Future getData({
    required int userLimit,
    required int fcmSenderId,
    required int messageGreaterThanId,
    required ChatLastUpdateAPICallBack callBack,
  }) async {
    this.userLimit = userLimit;
    this.fcmSenderId = fcmSenderId;
    this.messageGreaterThanId = messageGreaterThanId;
    this.callBack = callBack;

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //url
    String url =
        "${BackendConstant.baseUrlv2}/ChatBoth/getLastUpdateWithSpecificUser?";
    url += "user_limit=$userLimit";
    url += "&message_target_userid=$fcmSenderId";
    url += "&message_greater_than_id=$messageGreaterThanId";

    //header
    final token =  UserSingleTone.instance().getToken();
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
      Log.i("exe: $e");
      callBack(false, e.toString(), response);
    }
  }
}
