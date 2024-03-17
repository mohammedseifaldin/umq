import 'package:flutter/material.dart';
import 'package:umq/modules/home/data/source/get_categories_api.dart';
import 'package:umq/modules/home/provider/HomeChangeNotifier.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

extension GetCategoriesNotifier on HomeChangeNotifier {
  Future getCategories(BuildContext context) async {
    progressHomeUpdateStatus(context, true);

    final res = await GetCategoriesAPI().startAPI();
    if (res.done) {
      categories = res.categories;
    } else {
      if (context.mounted) {
        ToolsToast.i(context, res.errorMessage);
      }
    }
    if (context.mounted) {
      progressHomeUpdateStatus(context, false);
    }
  }
}
