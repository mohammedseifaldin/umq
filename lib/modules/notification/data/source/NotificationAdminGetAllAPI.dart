import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/notification/data/response/ResponseNotificationListPaginate.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef NotificationPaginateAPICallBack = Function(
    bool status, String msg, ResponseNotificationListPaginate response);

class NotificationAdminGetAllAPI {
  int? page;
  late NotificationPaginateAPICallBack callBack;
  String url = "";

  //data
  ResponseNotificationListPaginate response =
      ResponseNotificationListPaginate();

  Future getPage(int page, NotificationPaginateAPICallBack callBack) async {
    this.page = page;
    this.callBack = callBack;

    //{{domain_v1}}/notification_admin/?page=1&paginator=100
    url = BackendConstant.baseUrlv1 +
        "/notification_admin/?paginator=10&page=" +
        page.toString();

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
      response = ResponseNotificationListPaginate.fromJson(mapJson);

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
