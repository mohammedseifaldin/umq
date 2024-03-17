
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/data/model/MProductTools.dart';



import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';

extension  DescriptionProduct on ProductDetailState {



  Widget getDescriptionProduct( ) {
    return  selectedProduct == null
          ? CircularProgressIndicator()
          : showContent();
    }

  Widget showContent() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 10, right: 10),
      padding: EdgeInsets.all(20),
      width: DeviceTools.getWidth(context),
      height: 100,
      decoration: BoxDecoration(
          color: Colors.blue[100],
          borderRadius: BorderRadius.circular(25)),
      child: showColumn(),
    );
  }

  Widget showColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 20,
          child: tv_description_title()
        ),
        SizedBox(
          height: 20,
        ),
        Container(
            height: 20,
            child: tv_description_value() )
      ],
    );
  }

  Widget tv_description_title() {
    return TextTemplate.t('description',
      levelDS: LevelDS.l2
    );
  }

  Widget tv_description_value() {
    // return Text(selectedProduct!.description!)
    String des = MProductTools.getDescriptionByLang( context, selectedProduct!);
    return TextTemplate.t( des ,
    levelDS: LevelDS.l3
    );
  }


}
