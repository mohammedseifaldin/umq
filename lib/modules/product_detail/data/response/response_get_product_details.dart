import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';

class ResponseGetProductDetails {
  final ProductDetailsModel? product;
  final bool done;
  final String errorMessage;

  ResponseGetProductDetails({
    this.product,
    this.done = false,
    this.errorMessage = '',
  });
  // ResponseGetCategories.fromJson(Map<String, dynamic> json) {
  //   categories = List.generate(
  //     json.length,
  //     (index) => CategoryModel.fromJson(json[index]),
  //   );
  // }
}
