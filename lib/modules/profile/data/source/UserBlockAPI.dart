import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/data/general/GeneralCallBack.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

class UserBlockAPI {
  String target = ""; //action do at this id
  late GeneralCallBack callBack;
  int blockValue = 0; //0 means unblock, 1 means block

  Future block(String target, GeneralCallBack callBack) async {
    this.callBack = callBack;
    this.target = target;
    blockValue = 1;

    await _startAPI();
  }

  Future unblock(String target, GeneralCallBack callBack) async {
    this.callBack = callBack;
    this.target = target;
    this.blockValue = 0;

    await _startAPI();
  }

  Future _startAPI() async {
    String url = BackendConstant.baseUrlv2 + "/user/block";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, dynamic> body = Map();
    body["target"] = target;
    body["value"] = blockValue;

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
