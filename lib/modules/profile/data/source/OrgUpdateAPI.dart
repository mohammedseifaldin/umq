import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/data/general/GeneralCallBack.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

class OrgUpdateAPI {
  int targetId = 0;
  String nameEn = "";

  late GeneralCallBack callBack;

  Future getData(
      int targetId, String nameEn, GeneralCallBack callBack) async {
    this.callBack = callBack;
    this.targetId = targetId;
    this.nameEn = nameEn;

    await _startAPI();
  }

  Future _startAPI() async {
    String url = BackendConstant.baseUrlv2 + "/org/updateData";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = Map();
    body["name"] = nameEn;

    body["id"] = targetId;

    NetworkManagerDio().callBack(url,
        type: NetworkTypeDio.post,
        headers: header,
        body: body, callback: (status, msg, json) {
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
