//
//
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/shared/toolsChat/constant/EReadStatus.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ChatChatMessageStatusAPICallBack = Function(
    bool status, String msg, ResponseGeneral response);

class ChatMessageStatusAPI {
  String messageId = "";
  String statusRead = "";
  bool allowChangeRecorder = false;

  late ChatChatMessageStatusAPICallBack callBack;

  //data
  ResponseGeneral response = ResponseGeneral();

  //------------------------------------------------------------------ type

  Future received(
      {required String messageId,
      required ChatChatMessageStatusAPICallBack callBack}) async {
    this.messageId = messageId;
    this.callBack = callBack;

    //set type
    statusRead = EReadStatus.received.name;

    await _startAPI();
  }

  Future readed(
      {required String messageId,
      required bool allowChangeRecorder,
      required ChatChatMessageStatusAPICallBack callBack}) async {
    this.messageId = messageId;
    this.callBack = callBack;

    //set type
    this.allowChangeRecorder = allowChangeRecorder;
    statusRead = EReadStatus.readed.name;

    await _startAPI();
  }

  //----------------------------------------------------------------------  start

  Future _startAPI() async {
    //url
    String url = BackendConstant.baseUrlv2 + "/chatMessage/updateStatus";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //header
    Map<String, dynamic> body = Map();
    body["message_id"] = messageId;
    body["sender_id"] = await UserSingleTone.instance().getUserId();
    body["status_read"] = statusRead;
    body["allowChangeRecorder"] = allowChangeRecorder;
    // body["timestamp_request"] =  TimeTools.getCurrentTimestamp() ;

    //webservice
    NetworkManagerDio().callBack(url,
        headers: header,
        body: body,
        type: NetworkTypeDio.post, callback: (status, msg, json) {
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
      response = ResponseGeneral().fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, "Failed to download", response);
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
