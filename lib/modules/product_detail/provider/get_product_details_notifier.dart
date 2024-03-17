import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/data/source/get_products_api.dart';
import 'package:umq/modules/product_detail/provider/product_details_notifier.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension GetProductDetailsNotifier on ProductDetailsNotifier {
  Future getProductDetails(BuildContext context,
      {required int productId}) async {
    progressUpdateStatus(context, true);

    final res = await GetProductDetailsAPI().startAPI(productId: productId);
    if (res.done) {
      product = res.product;
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
