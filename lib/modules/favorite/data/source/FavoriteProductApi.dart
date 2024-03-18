import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/response/ResponseCartCounter.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/data/general/GeneralCallBack.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

class FavoriteProductApi {
  GeneralCallBack? callBack;
  ResponseCartCounter response = ResponseCartCounter();

  //------------------------------------------------------------------------ types

  Future changeStatus(
      int targetId, int isFavorite, GeneralCallBack callBack) async {
    this.callBack = callBack;

    String url = "${BackendConstant.baseUrlv1}/fav_product";

    //header
    final token = UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, String> body = {};
    body["product_id"] = targetId.toString();
    body["favorite"] = isFavorite.toString();

    //listener
    NetworkManagerDio().callBack(url, headers: header, body: body,
        callback: (status, msg, json) {
      if (status) {
        parse(json);
      } else {
        callBack(0, msg);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parse(Map<String, dynamic> mapJson) {
    try {
      var response = ResponseGeneral().fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

      //check
      if (ToolsAPI.isFailed(response.code)) {
        callBack!(0, "Failed");
        return;
      }

      //callback
      callBack!(1, "Success");
    } catch (e) {
      Log.i("action api - excep: $e");
      callBack!(0, e.toString());
    }
  }
}
