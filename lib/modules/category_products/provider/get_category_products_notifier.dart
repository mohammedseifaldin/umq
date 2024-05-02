import 'package:flutter/material.dart';
import 'package:umq/modules/category_products/data/source/get_products_api.dart';
import 'package:umq/modules/category_products/provider/category_products_notifier.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension GetCategoryProductsNotifier on CategoryProductsNotifier {
  Future getCategoryProducts(BuildContext context,
      {required int categoryId}) async {
    progressUpdateStatus(context, true);

    final res = await GetCategoryProductsAPI().startAPI(categoryId: categoryId);
    if (res.done) {
      products = res.products;
    } else {
      if (context.mounted) {
        ToolsToast.i(context, res.errorMessage);
      }
    }
    if (context.mounted) {
      progressUpdateStatus(context, false);
    }
  }
}
