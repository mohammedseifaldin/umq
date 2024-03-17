import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/cart/data/response/ResponseBadgeCounter.dart';
import 'package:umq/modules/cart/data/response/ResponseCartCounter.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/network/BackendConstant.dart';

typedef CounterChangeCallback = Function(
    bool status, String msg, ResponseCartCounter response);

class CartCounterApi {
  //------------------------------------------------------------------------ badge

  Future<ResponseBadgeCounter?> badgeCounter() async {
    var userId = await UserSingleTone.instance().getUserId();
    String url = BackendConstant.baseUrlv2 + "/cart_product/badge_counter";
    url += "?user_id=$userId";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //response
    var responseDio = await NetworkManagerDio().get(url, headers: header);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return ResponseBadgeCounter.fromJson(responseDio.data);
    } else {
      return null;
    }
  }

  //------------------------------------------------------------------------ increment/decremment/cancel

  Future<ResponseCartCounter?> incrementCart(
      int productId, int providerId) async {
    String url = BackendConstant.baseUrlv2 + "/cart_product/increment";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, String> body = Map();
    body["product_id"] = productId.toString();
    body["provider_id"] = providerId.toString();

    var responseDio =
        await NetworkManagerDio().post(url, headers: header, body: body);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return ResponseCartCounter.fromJson(responseDio.data);
    } else {
      return null;
    }
  }

  Future<ResponseCartCounter?> cancel(int id, int providerId) async {
    String url = BackendConstant.baseUrlv2 + "/cart_product/cancel";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, String> body = Map();
    body["product_id"] = id.toString();
    body["provider_id"] = providerId.toString();

    var responseDio =
        await NetworkManagerDio().post(url, headers: header, body: body);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return ResponseCartCounter.fromJson(responseDio.data);
    } else {
      return null;
    }
  }

  Future<ResponseCartCounter?> decrementCart(int id, int providerId) async {
    String url = BackendConstant.baseUrlv2 + "/cart_product/decrement";

    //header
    var token = await UserSingleTone.instance().getToken();
    Map<String, String> header = NetworkHeaderTools.bearerToken(token);

    //body
    Map<String, String> body = Map();
    body["product_id"] = id.toString();
    body["provider_id"] = providerId.toString();

    var responseDio =
        await NetworkManagerDio().post(url, headers: header, body: body);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return ResponseCartCounter.fromJson(responseDio.data);
    } else {
      return null;
    }
  }

  //------------------------------------------------------------------- parse
  //
  // void parseJsonChangeCounter(Map<String, dynamic> mapJson ) {
  //
  //   try {
  //
  //     response = ResponseCartCounter.fromJson( mapJson);
  //
  //     //check
  //     if ( ToolsAPI.isFailed( response.code) ) {
  //       callBack!( false, response.status??"Failed", response ) ;
  //       return;
  //     }
  //
  //     //callback
  //     callBack!( true,"Success", response   );
  //
  //   } catch (e ){
  //     Log.i( "exe: " + e.toString() );
  //     callBack!( false, e.toString(), response ) ;
  //   }
  // }
}
