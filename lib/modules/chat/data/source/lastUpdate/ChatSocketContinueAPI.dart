//
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/response/lastUpdate/ResponseChatLastUpdate.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ChatChatSocketContinueAPICallBack = Function(
    bool status, String msg, ResponseChatLastUpdate response);

class ChatSocketContinueAPI {
  int? userLimit = 0;
  int? indexLoop = 0;
  int? messageGreaterThanTime = 0;
  String? countryCode;
  late ChatChatSocketContinueAPICallBack callBack;

  //data
  ResponseChatLastUpdate response = ResponseChatLastUpdate();

  Future getData({
    required int userLimit,
    required int messageGreaterThanTime,
    required int indexLoop,
    required String countryCode,
    required ChatChatSocketContinueAPICallBack callBack,
  }) async {
    this.userLimit = userLimit;
    this.messageGreaterThanTime = messageGreaterThanTime;
    this.indexLoop = indexLoop;
    this.countryCode = countryCode;
    this.callBack = callBack;
    // Log.i("getData() "   );

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //url
    String url = "${BackendConstant.baseUrlv2}/ChatBoth/getSocketContinue?";
    url += "user_limit=$userLimit";
    url += "&message_greater_than_id=$messageGreaterThanTime";
    url += "&index_loop=$indexLoop";
    url += "&country_code=$countryCode";

    //header
    var token =  UserSingleTone.instance().getToken();
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
      Log.i("exe: $e");
      callBack(false, e.toString(), response);
    }
  }
}
