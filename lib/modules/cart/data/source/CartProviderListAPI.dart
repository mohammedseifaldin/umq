import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/teachers/data/response/ResponseListTeacher.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef CartProviderListAPICallBack = Function(
    bool status, String msg, ResponseListProvider response);

class CartProviderListAPI {
  int? page;
  late CartProviderListAPICallBack callBack;

  //data
  ResponseListProvider response = new ResponseListProvider();

  Future getData(CartProviderListAPICallBack callBack) async {
    this.callBack = callBack;

    await _startAPIGetAll();
  }

  //---------------------------------------------------------------------- type apis

  Future _startAPIGetAll() async {
    //my user
    var user = await UserSingleTone.instance().getUserId();

    //{{url_v2}}/cart_product/all_provider?user_id={{user_id}}
    String url = BackendConstant.baseUrlv2 +
        "/cart_product/all_provider?user_id=" +
        user.toString();

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
      response = ResponseListProvider.fromJson(mapJson);

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack(false, response.status ?? "Failed", response);
        return;
      }

      //check no cart data found
      if (response.data == null) {
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
