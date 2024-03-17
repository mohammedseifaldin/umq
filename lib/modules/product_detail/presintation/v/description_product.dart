import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';

class DescriptionProduct extends StatelessWidget {
  const DescriptionProduct({super.key, required this.product});
  final ProductDetailsModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: const EdgeInsets.all(20),
      width: DeviceTools.getWidth(context),
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(25)),
      child: Row(
        children: [
          TextFastor('Description: ', levelDS: LevelDS.l3, fontSize: 18),
          TextFastor(product.description, levelDS: LevelDS.l2)
        ],
      ),
    );
  }
}
