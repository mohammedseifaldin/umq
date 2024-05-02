import 'package:umq/modules/category_products/data/model/product_model.dart';


class ResponseGetCategoryProducts {
  final List<ProductModel> products;
  final bool done;
  final String errorMessage;

  ResponseGetCategoryProducts({
    this.products=const [],
    this.done=false,
    this.errorMessage='',
  });
  // ResponseGetCategories.fromJson(Map<String, dynamic> json) {
  //   categories = List.generate(
  //     json.length,
  //     (index) => CategoryModel.fromJson(json[index]),
  //   );
  // }
}
