import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/home/data/model/category_model.dart';
import 'package:umq/tools/network/BackendConstant.dart';

import '../response/response_get_categories_api.dart';

class GetCategoriesAPI {
  Future<ResponseGetCategories> startAPI() async {
    const url = "${BackendConstant.baseUrlv3}/all-services";
    final responseDio = await NetworkManagerDio().get(url);
    if (ValidateResponse.isStatusFrom200To210(responseDio)) {
      return parseJson(responseDio.data);
    } else {
      Log.i("getCategoriesApi - excep: ${responseDio.statusCode}");

      return ResponseGetCategories(
          done: false, errorMessage: "Unexpected error,sorry");
    }
  }

  ResponseGetCategories parseJson(List mapJson) {
    try {

      final categories = List.generate(
        mapJson.length,
        (index) => CategoryModel.fromJson(mapJson[index]),
      );
      return ResponseGetCategories(categories: categories, done: true);
    } catch (e) {
      Log.i("getCategoriesApi - excep: $e");
      return ResponseGetCategories(
          done: false, errorMessage: "Unexpected error,sorry");
    }
  }
}
