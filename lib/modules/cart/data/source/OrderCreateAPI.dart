import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/request/OrderRequest.dart';
import 'package:umq/modules/cart/data/response/ResponseOrderCreate.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/tools/network/ToolsAPI.dart';

typedef OrderSingleCallback = Function(
    bool status, String msg, ResponseOrderSingle response);

class OrderCreateAPI {
  OrderRequest orderRequest = new OrderRequest();
  ResponseOrderSingle response = new ResponseOrderSingle();

  late OrderSingleCallback callBack;

  Future create(OrderRequest orderRequest, OrderSingleCallback callBack) async {
    this.orderRequest = orderRequest;
    this.callBack = callBack;

    await _startAPI();
  }

  Future _startAPI() async {
    String url = BackendConstant.baseUrlv1 + "/order_product";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    /**
        {
        "user_id": "16",
        "payment_method": "cash",
        "payment_online_id": "0",
        "shipment_id": "1",
        "address_detail": "10 Street, Macka",
        "city_id": "1",
        "country": "SR",
        "status_order": "new",
        "product_detail": "@1=3"
        }
     */
    //body
    Map<String, dynamic> body = Map();
    body["user_id"] = await UserSingleTone.instance().getUserId();

    orderRequest.paymentMethod ??= "cash";
    body["payment_method"] = orderRequest.paymentMethod;
    body["payment_online_id"] = orderRequest.paymentOnlineId;

    orderRequest.shipmentId ??= "0";
    body["shipment_id"] = orderRequest.shipmentId;

    orderRequest.addressDetail ??= "NA";
    body["address_detail"] = orderRequest.addressDetail;
    body["city_id"] = orderRequest.cityId;
    body["country"] = orderRequest.country;
    body["status_order"] = orderRequest.statusOrder;
    body["product_detail"] = orderRequest.productDetail;

    //api
    NetworkManagerDio().callBack(url,
        type: NetworkTypeDio.post,
        headers: header,
        body: body, callback: (status, msg, json) {
      //Log.i("loginAPI - status: " + status.toString() );

      if (status) {
        parseJson(json);
      } else {
        callBack(false, "Refresh the Page", response);
      }
    });
  }

  //------------------------------------------------------------------- parse

  void parseJson(Map<String, dynamic> mapJson) {
    try {
      var response = ResponseOrderSingle.fromJson(mapJson);
      //Log.i( "login - parseJson() - response $response "  );

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
