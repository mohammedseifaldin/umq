import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/resourceProject/DimenProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ProductImage extends StatelessWidget {
  const ProductImage({super.key, required this.product});
  final ProductDetailsModel product;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 200,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(
            right: DimenProject.radiusScaffoldCorner / 2,
            left: DimenProject.radiusScaffoldCorner / 2,
            bottom: 10),
        decoration: BoxDecoration(
            color: Colors.white, // HexColor(ColorProject.white_oxygen),
            borderRadius:
                BorderRadius.circular(DimenProject.radiusScaffoldCorner)),
        child: Stack(
          children: [
            EmptyView.empty(DeviceTools.getWidth(context), 200),
            ImageFastor(
              context: context,
              width: DeviceTools.getWidth(context),
              height: 200,
              assetAspectRatio: DrawableProject.placeholderImage,
              urlBackground: product.image,
              onPressed: () {
                GoTo.fullScreenImage(context, product.image);
              },
            ),
            // Positioned(right: 0, child: columnButton())
          ],
        ),
      ),
    );
  }
}
// class ImageButtons extends StatelessWidget {
//   const ImageButtons({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         FavoriteButton(
//           favorite: selectedProduct!.favorite!,
//           backgroundColor: Colors.white,
//           onTap: () async {
//             // await changeFavoriteStatus();
//           },
//         ),
//         const SizedBox(
//           height: 15,
//         ),
//         Material(
//           child: InkWell(
//             onTap: () async {
//               await ShareInformationHelper.shareProduct(
//                   context, selectedProduct!);
//             },
//             child: const Icon(
//               Icons.share,
//               color: Colors.blue,
//               size: 35,
//             ),
//           ),
//         )
//       ],
//     );
  
//   }
// }
