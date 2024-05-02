import 'package:fastor_app_ui_widget/resource/template/crop/CropTemplate.dart';
import 'package:fastor_app_ui_widget/resource/template/image/ImageFastor.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/category_products/data/model/product_model.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/toolsUI/Widgets/provider_rounded_image.dart';

class CategoryProductView extends StatelessWidget {
  const CategoryProductView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoTo.productDetailById(context, product.id);
        // Tools.ShowSuccessMessage(context, 'Comming soon product');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10,horizontal: 12),
        elevation: 10,
        clipBehavior: Clip.antiAlias,
        color: Colors.grey.shade100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            ProviderRoundedImage(imageUrl:product.image),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    product.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}
