import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/dashboard/data/response/ResponseAdminDashboard.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef DashboardAdminCallBack = Function(
    bool status, String msg, ResponseAdminDashboard response);

class DashboardAdminGetAPI {
  int? page;
  late DashboardAdminCallBack callBack;

  //data
  ResponseAdminDashboard response = ResponseAdminDashboard();

  Future getData(DashboardAdminCallBack callBack) async {
    this.callBack = callBack;

    await _startAPIGetAll();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPIGetAll() async {
    //{{url_v2}}/dashboard/admin/counter_analytics
    String url =
        BackendConstant.baseUrlv2 + "/dashboard/admin/counter_analytics";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, headers: header,
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
      response = ResponseAdminDashboard.fromJson(mapJson);

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
