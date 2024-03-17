import 'package:fastor_app_ui_widget/resource/resources/ds/LevelDS.dart';
import 'package:fastor_app_ui_widget/resource/template/image/ImageFastor.dart';
import 'package:fastor_app_ui_widget/resource/template/text/TextFastor.dart';
import 'package:fastor_app_ui_widget/resource/toolsFastor/device/DeviceTools.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';

class ProviderWidget extends StatelessWidget {
  const ProviderWidget({super.key, required this.product});
  final ProductDetailsModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: const EdgeInsets.all(20),
      width: DeviceTools.getWidth(context),
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(25)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
            Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: ImageFastor(
              context: context,
              width: 70,
              height: 70,
              assetAspectRatio: DrawableProject.placeholderImage,
              urlBackground: product.provider.photo,
            ),
          ),
          Row(
            children: [
              TextFastor('Provider: ', levelDS: LevelDS.l3, fontSize: 18),
              TextFastor(product.provider.name, levelDS: LevelDS.l2),
            ],
          ),
         Row(
            children: [
              TextFastor('email: ', levelDS: LevelDS.l3, fontSize: 16),
              TextFastor(product.provider.email, levelDS: LevelDS.l2),
            ],
          ),
          
        ],
      ),
    );
  }
}
