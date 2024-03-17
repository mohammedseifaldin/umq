import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/product/data/response/ResponseSingleProduct.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ProviderDetailCallBack = Function(
    bool status, String msg, ResponseSingleProvider responseSingleProvider);

class ProviderDetailAPI {
  ResponseSingleProvider response = new ResponseSingleProvider();

  late ProviderDetailCallBack callBack;
  int providerId = 0; //0 means unblock, 1 means block

  Future getData(int providerId, ProviderDetailCallBack callBack) async {
    this.callBack = callBack;
    this.providerId = providerId;

    await _startAPI();
  }

  Future _startAPI() async {
    // Log.i("ProviderDetailAPI - _startAPI - providerId: " + providerId.toString() );

    String url = BackendConstant.baseUrlv2Public +
        "/provider/show?id=" +
        providerId.toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, headers: header, type: NetworkTypeDio.get,
        callback: (status, msg, json) {
      //Log.i("ProviderDetailAPI - status: " + status.toString() );

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
      response = ResponseSingleProvider().fromJson(mapJson);
      // Log.i( "ProviderDetailAPI - parseJson() - response $response "  );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, "Failed to download", response);
        return;
      }

      //callback
      callBack(true, "Success", response);
    } catch (e) {
      Log.i("action api - excep: " + e.toString());
      callBack(false, e.toString(), response);
    }
  }
}
