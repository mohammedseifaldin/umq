import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/category_products/data/model/product_model.dart';

class CategoryProductsNotifier extends ChangeNotifier {
  //---------------------------------------------------------------- variable

  //++++++++++++++++++++++++++ page : home
  ScrollController scrollController = ScrollController();
  bool inProgress = false;
  List<ProductModel> products = [];

  //---------------------------------------------------------------- instance

  static CategoryProductsNotifier getListenFalse(BuildContext context) {
    return Provider.of<CategoryProductsNotifier>(context, listen: false);
  }

  static CategoryProductsNotifier getListenTrue(BuildContext context) {
    return Provider.of<CategoryProductsNotifier>(context, listen: true);
  }

  void progressUpdateStatus(BuildContext context, bool newUpdate) {
    inProgress = newUpdate;
    notifyListeners();
  }
}
