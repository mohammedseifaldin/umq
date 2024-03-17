import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/category_products/data/model/product_model.dart';
import 'package:umq/modules/category_products/data/reponse/response_get_products.dart';
import 'package:umq/tools/network/BackendConstant.dart';

class GetCategoryProductsAPI {
  Future<ResponseGetCategoryProducts> startAPI(
      {required int categoryId}) async {
    final url = "${BackendConstant.baseUrlv3}/products-service/$categoryId";
    final responseDio = await NetworkManagerDio().get(url);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return parseJson(responseDio.data["products"]);
    } else {
      Log.i("getCategoryProductsApi - excep: ${responseDio.statusCode}");

      return ResponseGetCategoryProducts(
          done: false, errorMessage: "Unexpected error,sorry");
    }
  }

  ResponseGetCategoryProducts parseJson(List mapJson) {
    try {
      final products = List.generate(
        mapJson.length,
        (index) => ProductModel.fromJson(mapJson[index]),
      );
      return ResponseGetCategoryProducts(products: products, done: true);
    } catch (e) {
      Log.i("getCategoryProductsApi - excep: $e");
      return ResponseGetCategoryProducts(
          done: false, errorMessage: "Unexpected error,sorry");
    }
  }
}
