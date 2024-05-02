import 'package:umq/modules/home/data/model/category_model.dart';

class ResponseGetCategories {
  final List<CategoryModel> categories;
  final bool done;
  final String errorMessage;

  ResponseGetCategories({
    this.categories=const [],
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
