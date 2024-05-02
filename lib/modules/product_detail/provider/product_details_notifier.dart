import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';

class ProductDetailsNotifier extends ChangeNotifier {
  //---------------------------------------------------------------- variable

  //++++++++++++++++++++++++++ page : home
  ScrollController scrollController = ScrollController();
  bool inProgress = false;
  ProductDetailsModel? product;

  //---------------------------------------------------------------- instance

  static ProductDetailsNotifier getListenFalse(BuildContext context) {
    return Provider.of<ProductDetailsNotifier>(context, listen: false);
  }

  static ProductDetailsNotifier getListenTrue(BuildContext context) {
    return Provider.of<ProductDetailsNotifier>(context, listen: true);
  }

  void progressUpdateStatus(BuildContext context, bool newUpdate) {
    inProgress = newUpdate;
    notifyListeners();
  }
}
