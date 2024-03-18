import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/chat/data/response/userChatList/ResponseChatUserList.dart';
import 'package:umq/modules/chat/presentation/UserListPage/c/paginate/ChatScrollManager.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ChatUserListAPICallBack = Function(
    bool status, String msg, ResponseChatUserList response);

class ChatUserListAPI {
  int? page;
  late ChatUserListAPICallBack callBack;

  //data
  ResponseChatUserList response = ResponseChatUserList();

  Future getPaginate(int page, ChatUserListAPICallBack callBack) async {
    this.page = page;
    this.callBack = callBack;

    await _startAPIGetAll();
  }

  Future getAllData({required ChatUserListAPICallBack callBack}) async {
    this.callBack = callBack;

    await _startAPIGetAll();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPIGetAll() async {
    //url
//{{local_v2}}/chatUser/chatWithMeUsers?page=1&paginator=30
    String url = "";
    if (page == null) {
      url = BackendConstant.baseUrlv2 +
          "/chatUser/chatWithMeUsers?paginator=10000000&page=1";
    } else {
      String paginator = ChatPaginateConstant.paginator.toString();
      url = BackendConstant.baseUrlv2 +
          "/chatUser/chatWithMeUsers?paginator=" +
          paginator +
          "&page=" +
          page.toString();
    }

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //check login
    if (await UserSingleTone.instance().isGuest()) {
      callBack(false, "Login First", response);
      return;
    }

    //webservice
    NetworkManagerDio().callBack(url,
        isEnableLogDioPretty: true,
        headers: header, callback: (status, msg, json) {
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
      response = ResponseChatUserList.fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, response.status ?? "Failed to download", response);
        return;
      }

      // //check have data
      // if ( response.data == null  ) {
      //   callBack( false,"Failed to download data"  , response) ;
      //   return;
      // }
      //
      // //check have user
      // bool isEmpty =  response.data!.data!.length == 0;
      // if ( isEmpty  ) {
      //   callBack( false, "No Data Found" , response) ;
      //   return;
      // }
      //  Log.i( "ChatUserListAPI - parseJson() - response: " + response.toString() );
      // Log.i( "ChatUserListAPI - parseJson() - response.length: " + response.data!.data!.length.toString()  );

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("exe: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
