import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';
import 'package:umq/modules/product_detail/data/response/response_get_product_details.dart';
import 'package:umq/tools/network/BackendConstant.dart';

class GetProductDetailsAPI {
  Future<ResponseGetProductDetails> startAPI({required int productId}) async {
    final url = "${BackendConstant.baseUrlv3}/products-details/$productId";
    final responseDio = await NetworkManagerDio().get(url);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return parseJson(responseDio.data);
    } else {
      Log.i("getProductDetailsApi - excep: ${responseDio.statusCode}");

      return ResponseGetProductDetails(
          done: false, errorMessage: "Unexpected error,sorry");
    }
  }

  ResponseGetProductDetails parseJson(Map<String, dynamic> mapJson) {
    try {
      return ResponseGetProductDetails(
          product: ProductDetailsModel.fromJson(mapJson), done: true);
    } catch (e) {
      Log.i("getProductDetailsApi - excep: $e");
      return ResponseGetProductDetails(
          done: false, errorMessage: "Unexpected error,sorry");
    }
  }
}
