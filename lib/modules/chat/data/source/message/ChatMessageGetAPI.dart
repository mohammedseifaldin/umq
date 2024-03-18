import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/response/message/ResponseChatMessageList.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ChatChatMessageGetAPICallBack = Function(bool status, String msg,
    bool isFinishAllPages, ResponseChatMessageList response);

class ChatMessageGetAPI {
  int page = 1;
  int paginator = ChatPaginateConstant.paginator;
  int target = 0; //user id target or group id

  late ChatChatMessageGetAPICallBack callBack;

  //data
  ResponseChatMessageList response = ResponseChatMessageList();

  Future getData(
      {required int page,
      required int paginator,
      required int target,
      required ChatChatMessageGetAPICallBack callBack}) async {
    this.page = page;
    this.paginator = paginator;
    this.target = target;
    this.callBack = callBack;

    await _startAPI();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPI() async {
    //url
    //{{local_v2}}/chatMessage/getMessageWithSpecificUser?page=1&target=16&paginator=100&convert_status_readed=1
    String url =
        BackendConstant.baseUrlv2 + "/chatMessage/getMessageWithSpecificUser?";
    url += "page=" + page.toString();
    url += "&paginator=" + paginator.toString();
    url += "&target=" + target.toString();
    url += "&convert_status_readed=1";
    // url += "&timestamp_request=" + TimeTools.getCurrentTimestamp().toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //webservice
    NetworkManagerDio().callBack(url,
        headers: header,
        isEnableLogDioPretty: false,
        type: NetworkTypeDio.get, callback: (status, msg, json) {
      //Log.i( "_startAPI()  - status: " + json.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(false, "Refresh the Page", false, response);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      response = ResponseChatMessageList().fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(
            false, response.status ?? "Failed in Download", false, response);
        return;
      }
      //bool is first time
      bool isFinishAllPages = false;
      if (ToolsAPI.isTrue(response.first_time_chat)) {
        isFinishAllPages = true;
        callBack(true, "Success", isFinishAllPages, response);
        return;
      }

      //check is finished pagainte
      isFinishAllPages = ToolsAPI.isPaginateLaravelEnd(
          response.data!.currentPage, response.data!.last_page);

      //callback
      callBack(true, "Success", isFinishAllPages, response);
    } catch (e) {
      Log.i("ChatMessageGetAPI - exe: " + e.toString());
      callBack(false, e.toString(), false, response);
    }
  }
}
