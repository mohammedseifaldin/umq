import 'package:dio/dio.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/response/ResponseCartProductList.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';

// typedef CartListCallBack = Function(bool status, String msg , ResponseCartProductList response );

class CartListAPI {
  Future<ResponseCartProductList?> getData() async {
    //my user
    var user = await UserSingleTone.instance().getUserId();

    //{{local_v2}}/cart_product/getCartUser?user_id=16
    String url = BackendConstant.baseUrlv2 +
        "/cart_product/cart_products?user_id=" +
        user.toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    Response responseDio = await NetworkManagerDio()
        .get(url, headers: header, isEnableLogDioPretty: false);

    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return ResponseCartProductList().fromJson(responseDio.data);
    } else {
      return null;
    }
  }
}
