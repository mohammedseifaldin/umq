import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/modules/teachers/data/response/ResponseRateTeacher.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/product/data/response/ResponseSingleProduct.dart';
import 'package:umq/modules/teachers/data/response/ResponseSingleTeacher.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ProviderRateCallBack = Function(
    bool status, String msg, ResponseRateProvider response);

class ProviderRateAPI {
  ResponseRateProvider response = new ResponseRateProvider();

  late ProviderRateCallBack callBack;
  int providerId = 0; //0 means unblock, 1 means block
  double rate = 0.0;

  Future getData(
      int providerId, double rate, ProviderRateCallBack callBack) async {
    this.callBack = callBack;
    this.rate = rate;
    this.providerId = providerId;

    await _startAPI();
  }

  Future _startAPI() async {
    // Log.i("ProviderRateAPI - _startAPI - providerId: " + providerId.toString() );

    String url = BackendConstant.baseUrlv1 + "/rate_provider";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);
    int myUserId = await UserSingleTone.instance().getUserId();

    //body
    Map<String, dynamic> body = Map();
    body["user_id"] = myUserId;
    body["provider_id"] = providerId;
    body["value"] = rate.toString();

    //dio
    NetworkManagerDio().callBack(url, body: body, headers: header,
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
      response = ResponseRateProvider.fromJson(mapJson);
      //  Log.i("ProviderRateAPI - parseJson() - response: " + response.toString() );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, response.status ?? "Failed", response);
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
