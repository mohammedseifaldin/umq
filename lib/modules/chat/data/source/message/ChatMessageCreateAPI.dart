//
//
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/tools/data/general/ResponseGeneral.dart';

import 'package:umq/tools/network/BackendConstant.dart';

import 'package:umq/modules/chat/data/response/lastUpdate/ResponseChatLastUpdate.dart';
import 'package:umq/modules/chat/data/response/message/ResponseCreateMessage.dart';
import 'package:umq/modules/chat/shared/toolsChat/constant/EReadStatus.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';

import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/time/TimeTools.dart';

typedef ChatMessageCreateAPICallBack = Function(
    bool status, String msg, ResponseCreateMessage response);

class ChatMessageCreateAPI {
  late ChatMessageCreateAPICallBack callBack;

  //data
  ResponseCreateMessage response = ResponseCreateMessage();

  MChatMessage mMessageNeeded = MChatMessage();

  //fix time zone
  String? countryCode;

  Future createNew(
      {required MChatMessage mMessageNeeded,
      required ChatMessageCreateAPICallBack callBack}) async {
    this.mMessageNeeded = mMessageNeeded;
    this.callBack = callBack;

    countryCode = await ZoneTools.getZoneCountryDialCode("+20");

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //url
    //{{local_v2}}/chatMessage/createMessageWithSpecificUser
    String url = BackendConstant.baseUrlv2 +
        "/chatMessage/createMessageWithSpecificUser";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //header
    Map<String, dynamic> body = Map();
    body["text"] = mMessageNeeded.text;
    body["image"] = mMessageNeeded.image;
    body["video"] = mMessageNeeded.video;
    body["recorder"] = mMessageNeeded.recorder;
    body["senderId"] = await UserSingleTone.instance().getUserId();
    body["receiverId"] = mMessageNeeded.receiverId;
    body["country_code"] = countryCode;
    // body["timestamp_request"] =  TimeTools.getCurrentTimestamp() ;

    //webservice
    NetworkManagerDio().callBack(url,
        isEnableLogDioPretty: true,
        headers: header,
        body: body,
        type: NetworkTypeDio.post, callback: (status, msg, json) {
      // Log.i( "_startAPI()  - status: " + json.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(false, "Refresh the Page", response);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      response = ResponseCreateMessage().fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, response.status ?? "Failed", response);
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
