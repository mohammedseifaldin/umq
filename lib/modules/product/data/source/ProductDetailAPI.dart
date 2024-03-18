import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/product/data/response/ResponseSingleProduct.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef ProductDetailCallBack = Function(
    bool status, String msg, ResponseSingleProduct mProduct);

class ProductDetailAPI {
  ResponseSingleProduct response = ResponseSingleProduct();

  late ProductDetailCallBack callBack;
  int productId = 0; //0 means unblock, 1 means block

  Future getData(int productId, ProductDetailCallBack callBack) async {
    this.callBack = callBack;
    this.productId = productId;

    await _startAPI();
  }

  Future _startAPI() async {
    String url =
        BackendConstant.baseUrlv2Public + "/product/" + productId.toString();

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    NetworkManagerDio().callBack(url, headers: header, type: NetworkTypeDio.get,
        callback: (status, msg, json) {
      //Log.i("ProductDetailAPI - status: " + status.toString() );

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
      var response = ResponseSingleProduct().fromJson(mapJson);
      Log.i("ProductDetailAPI - parseJson() - response $response ");

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
