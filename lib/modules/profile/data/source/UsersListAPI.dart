import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/response/ResponseUserList.dart';

import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';
import 'package:umq/tools/values/ToolsValue.dart';

typedef UserListCallBack = Function(
    bool status, String msg, ResponseUserList response);

class UsersListAPI {
  late int page;
  String search_txt = "";
  String roleSelected = "";
  late UserListCallBack callBack;

  //data
  ResponseUserList response = ResponseUserList();

  Future getData(int page, String search_txt, String roleSelected,
      UserListCallBack callBack) async {
    this.page = page;
    this.callBack = callBack;
    this.search_txt = search_txt;

    //check all role
    if (roleSelected == "All") {
      roleSelected = "";
    }
    this.roleSelected = roleSelected;

    //check there is no "search" and no "role"
    bool isSearchText = ToolsValue.isValid(search_txt);
    if (isSearchText) {
      await _startAPISearchText();
    } else {
      await _startAPIGetAll();
    }
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPISearchText() async {
    String url = BackendConstant.baseUrlv2 + "/users/search_text";

    //body
    Map<String, dynamic> body = Map();
    body["search"] = search_txt;

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, headers: header, body: body,
        callback: (status, msg, json) {
      //Log.i("loginAPI - status: " + status.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(false, msg, response);
      }
    });
  }

  Future _startAPIGetAll() async {
    String url = BackendConstant.baseUrlv1 +
        "/users/?paginator=10&page=" +
        page.toString();

    if (ToolsValidation.isValid(roleSelected)) {
      url += "&role=" + roleSelected.toString();
    }

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    await NetworkManagerDio().callBack(url,
        type: NetworkTypeDio.get,
        headers: header, callback: (status, msg, json) {
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
      var response = ResponseUserList().fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, "Failed to download", response);
        return;
      }

      //check have data
      if (response.dataLaravel == null) {
        callBack(false, "Failed to download data", response);
        return;
      }

      //check have user
      if (response.dataLaravel!.dataUsers == null) {
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
