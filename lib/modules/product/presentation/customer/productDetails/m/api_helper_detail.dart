import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/data/general/ResponseGeneral.dart';
import 'package:umq/tools/network/BackendConstant.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/m/ResponseProductDetail.dart';
import 'package:umq/tools/cache/user_single_tone.dart';

class ApiHelper {
  ApiHelper._();

  static ApiHelper apiHelper = ApiHelper._();

  Dio dio = Dio();

  Future<ResponseGeneral> favoriteApi(int id, int changeStatusTo) async {
    String url = BackendConstant.baseUrlv1 + '/fav_product';

    String token = await UserSingleTone.instance().getToken();
    int userId = await UserSingleTone.instance().getUserId();

    Response response = await dio.post(url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {
          "user_id": userId.toString(),
          "product_id": "$id",
          "favorite": "$changeStatusTo"
        });
    Log.i("favoriteApi - response.statusCode - response: " +
        response.data.toString());

    ResponseGeneral responseGeneral = ResponseGeneral().fromJson(response.data);
    return responseGeneral;
  }

  Future incrementCart(int id) async {
    Dio dio = Dio();
    String url = BackendConstant.baseUrlv2 + "/cart_product/increment";

    String token = await UserSingleTone.instance().getToken();

    Response response = await dio.post(url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {"product_id": "$id"});
    print(response.data);
    print(response.statusCode);
    // List<dynamic> products = response.data;
    return response.data;
  }

  Future<dynamic> singleProduct(int id) async {
    Dio dio = Dio();
    String url = BackendConstant.baseUrlv2Public + "/product/$id";

    String token = await UserSingleTone.instance().getToken();
    //Log.i( "singleProduct - token " + token );

    Response response = await dio.get(url,
        options: Options(headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        }));
    dynamic json = response.data;

    return json;
  }

  Future decrementCart(int id) async {
    String url = BackendConstant.baseUrlv2 + "/cart_product/decrement";

    String token = await UserSingleTone.instance().getToken();

    Response response = await dio.post(url,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        ),
        data: {"product_id": "$id"});
    print(response.data);
    print(response.statusCode);

    return response.data;
  }
}
