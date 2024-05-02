import 'package:flutter/material.dart';
import 'package:umq/modules/home/data/model/category_model.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/Widgets/provider_rounded_image.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({super.key, required this.category});
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        GoTo.categoryProductsById(context, category.id);
        // Tools.ShowSuccessMessage(context, 'Comming soon products');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 10,
        color: Colors.grey.shade100,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Row(
          children: [
            ProviderRoundedImage(imageUrl: category.image),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category.name,
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    category.description,
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
