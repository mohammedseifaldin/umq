import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/notification/data/response/ResponseNotificationList.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef NotificationListAPICallBack = Function(
    bool status, String msg, ResponseNotificationList response);

class NotificationUserListAPI {
  int? limit;
  late NotificationListAPICallBack callBack;
  String url = "";

  //data
  ResponseNotificationList response = ResponseNotificationList();

  Future getUserListNotification(
      int limit, NotificationListAPICallBack callBack) async {
    this.limit = limit;
    this.callBack = callBack;

    //{{local_v2}}/notification_admin/getUserListNotification?limit=100
    url = BackendConstant.baseUrlv2 +
        "/notification_normal/getNormalUserListNotification?limit=" +
        limit.toString();

    await _startAPIGetAll();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPIGetAll() async {
    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, type: NetworkTypeDio.get, headers: header,
        callback: (status, msg, json) {
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
      response = ResponseNotificationList.fromJson(mapJson);

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
