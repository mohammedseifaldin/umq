import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/data/general/GeneralCallBack.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

class UserUpdateAPI {
  int target_user_id = 0;
  String name = "";
  String email = "";
  int city_id = 0;
  String photo = "";

  late GeneralCallBack callBack;

  Future getData(int target_user_id, String name, String email, int city_id,
      String photo, GeneralCallBack callBack) async {
    this.target_user_id = target_user_id;
    this.callBack = callBack;
    this.name = name;
    this.email = email;
    this.city_id = city_id;
    this.photo = photo;

    await _startAPI();
  }

  Future _startAPI() async {
    String url = BackendConstant.baseUrlv2 + "/user/updateData";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = Map();
    body["name"] = name;
    body["email"] = email;
    body["city_id"] = city_id;
    body["photo"] = photo;

    /**
     * must set here "target_user_id"  for admin user role type only
     */
    body["target_user_id"] = target_user_id;

    NetworkManagerDio().callBack(url, headers: header, body: body,
        callback: (status, msg, json) {
      //Log.i("loginAPI - status: " + status.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(0, msg);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      var response = ResponseGeneral().fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(0, "Failed to download");
        return;
      }

      //callback
      callBack(1, "Success");
    } catch (e) {
      Log.i("action api - excep: " + e.toString());
      callBack(0, e.toString());
    }
  }
}
