import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product_detail/data/model/product_detail_model.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class InfoProduct extends StatelessWidget {
  const InfoProduct({super.key, required this.product});
  final ProductDetailsModel product;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.all(10),
      // height: 110,
      decoration: BoxDecoration(
          color: Colors.blue[100], borderRadius: BorderRadius.circular(25)),
      child: Column(
        children: [
          barNameAndRate(context),
          const SizedBox(
            height: 5,
          ),
          lineSepartor(),
          // rowPrice(context)
        ],
      ),
    );
  }

  Widget barNameAndRate(context) {
    return Stack(
      children: [
        EmptyView.empty(DeviceTools.getWidth(context), 25),
        Positioned(
            left: 0,
            child: TextFastor(
              product.name,
              levelDS: LevelDS.l2,
              color: HexColor(ColorProject.black_1),
            )),
        // Positioned(right: 0, child: rateRow())
      ],
    );
  }
  //  Widget rateRow() {
  //   return Row(
  //     children: [
  //       TextFastor('${product.rate}',
  //       textAlign: TextAlign.start,
  //       padding: EdgeInsets.only(right: DSDimen.space_level_3),
  //       levelDS: LevelDS.l2),
  //       Material(
  //         color: Colors.transparent,
  //         child: Icon(
  //           Icons.star,
  //           color: Colors.yellow[600],
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget lineSepartor() {
    return Container(
      height: 3,
      color: Colors.blue[200],
    );
  }

  // Widget rowPrice(context) {
  //   return Stack(
  //     children: [
  //       EmptyView.empty(DeviceTools.getWidth(context), 25),
  //       // TextFastor('price',
  //       // padding: const EdgeInsets.only(top: 10), levelDS: LevelDS.l2),
  //       // Positioned(right: 0, child: TextFastor("${product.price} S.R.",
  //       //       padding: const EdgeInsets.only(top: 10), levelDS: LevelDS.l2);)
  //     ],
  //   );
  // }
}
