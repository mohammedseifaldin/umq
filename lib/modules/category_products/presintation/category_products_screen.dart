import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/category_products/provider/category_products_notifier.dart';
import 'package:umq/modules/category_products/provider/get_category_products_notifier.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/itemList/product/category_product_view.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';

class CategoryProductsScreen extends StatefulWidget {
  final int categoryId;

  const CategoryProductsScreen({super.key, required this.categoryId});

  @override
  CategoryProductsState createState() {
    return CategoryProductsState();
  }
}

class CategoryProductsState extends State<CategoryProductsScreen> {
  late CategoryProductsNotifier provider;
  @override
  void initState() {
    super.initState();
    provider = CategoryProductsNotifier.getListenFalse(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider.getCategoryProducts(context, categoryId: widget.categoryId);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = CategoryProductsNotifier.getListenTrue(context);

    return PageFastor(
      this,
      title: "Category Products",
      content: getContent(),
      statusBarColorCustom:HexColor(ColorProject.black_4),
      scrollController: provider.scrollController,
      widgetBackground:
          BackgroundCardPage(toolbarHeight: ToolbarHomeScuba.frameHeight),
      toolbar: ToolbarHomeScuba(context, title: "Category Products"),
      toolbar_height: ToolbarHomeScuba.frameHeight,
    );
  }

  getContent() {
    late final List<Widget> list;
    final progress = progressViewIfNeeded();
    if (progress != null) {
      list = [progress];
    } else {
      final products = List.generate(
        provider.products.length,
        (index) => CategoryProductView(
          product: provider.products[index],
        ),
      );
      list = products;
    }
    return ListViewTemplate.t(
        context: context, children: list, axis: Axis.vertical);
  }

  Widget? progressViewIfNeeded() {
    if (provider.inProgress) {
      return Container(
        alignment: Alignment.center,
        width: DeviceTools.getWidth(context),
        child: ProgressCircleFastor(),
      );
    }
    return null;
  }
}
