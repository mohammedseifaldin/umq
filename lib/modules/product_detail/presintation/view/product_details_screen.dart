import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/presintation/v/contact_widget.dart';
import 'package:umq/modules/product_detail/presintation/v/description_product.dart';
import 'package:umq/modules/product_detail/presintation/v/info_product.dart';
import 'package:umq/modules/product_detail/presintation/v/price_widget.dart';
import 'package:umq/modules/product_detail/presintation/v/product_image.dart';
import 'package:umq/modules/product_detail/presintation/v/provider_widget.dart';
import 'package:umq/modules/product_detail/provider/get_product_details_notifier.dart';
import 'package:umq/modules/product_detail/provider/product_details_notifier.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';

class ProductDetailsScreen extends StatefulWidget {
  final int productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  ProductDetailsState createState() {
    return ProductDetailsState();
  }
}

class ProductDetailsState extends State<ProductDetailsScreen> {
  late ProductDetailsNotifier provider;
  @override
  void initState() {
    super.initState();
    provider = ProductDetailsNotifier.getListenFalse(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      provider.getProductDetails(context, productId: widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    provider = ProductDetailsNotifier.getListenTrue(context);

    return PageFastor(
      this,
      statusBarColorCustom: HexColor(ColorProject.black_4),
      title: "Product Details",
      content: getContent(),
      scrollController: provider.scrollController,
      widgetBackground:
          BackgroundCardPage(toolbarHeight: ToolbarHomeScuba.frameHeight),
      toolbar: ToolbarHomeScuba(context, title: "Product Details"),
      toolbar_height: ToolbarHomeScuba.frameHeight,
    );
  }

  getContent() {
    if (provider.inProgress) {
      return Container(
        alignment: Alignment.center,
        width: DeviceTools.getWidth(context),
        child: ProgressCircleFastor(),
      );
    } else if (provider.product == null) {
      return const SizedBox();
    }
    return ListViewTemplate.t(
      context: context,
      axis: Axis.vertical,
      children: [
        const SizedBox(height: 20),
        ProductImage(product: provider.product!),
        const SizedBox(
          height: 20,
        ),
        InfoProduct(product: provider.product!),
        DescriptionProduct(product: provider.product!),
        PriceProduct(product: provider.product!),
        ProviderWidget(product: provider.product!),
        const SizedBox(
          height: 20,
        ),

        ContactWidget(
          provider: provider,
        ),
        const SizedBox(
          height: 20,
        ),
        // getCartWidget(),

        const SizedBox(
          height: 60,
        ),
      ],
    );
  }
}
