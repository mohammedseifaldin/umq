import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/m/list/ResponseSliderList.dart';

import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef SlideListCallBack = Function(
    bool status, String msg, ResponseSliderList response);

class SlideListAPI {
  late int page;

  late SlideListCallBack callBack;

  //data
  ResponseSliderList response = ResponseSliderList();

  Future getData(int page, SlideListCallBack callBack) async {
    this.page = page;
    this.callBack = callBack;

    await _startAPIGetAll();
  }

  Future _startAPIGetAll() async {
    //{{DEVServerURL}}/sliders/?page=1&paginator=100
    String url = BackendConstant.baseUrlv1 +
        "/sliders/?paginator=10&page=" +
        page.toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, headers: header, type: NetworkTypeDio.get,
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
      var response = ResponseSliderList.fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

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

      //check have user
      if (response.data!.data == null) {
        callBack(false, "No Data Found", response);
        return;
      }

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("UserListAPI class - excep: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
