
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/toolsUI/itemList/product/horizontal_list/ItemProductHorizontal.dart';
import 'package:umq/toolsUI/no_data_widget.dart';


extension ProductsGallery on ProviderDetailsState {

  Widget getProductsGallery( ) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          '* Products',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800

          ),
        ),
        const SizedBox(
          height: 15,
        ),
        productsGalleryWidget(),
      ],
    );
  }

  bool checkHaveDataProduct() {
    if( responseSingleProvider.data  == null ) {
      return false;
    }

    if( responseSingleProvider.data!.productProvider == null ) {
      return false;
    }
    if( responseSingleProvider.data!.productProvider!.length == 0 ) {
      return false;
    }
    //responseSingleProvider.data!.productProvider!.length == 0
    return true;
  }


  Widget productsGalleryWidget() {

    if( checkHaveDataProduct() == false ) {
      Log.i("productsGalleryWidget() - checkHaveDataProduct() == false  - stop!"   );
      return noData();
    }

    //Log.i("productsGalleryWidget() - len:  " + responseSingleProvider.data!.productProvider!.length.toString() );

    // list
    List<Widget> listWidget = [];
    for (int i = 0; i < responseSingleProvider.data!.productProvider!.length; i++) {
      MProduct m = responseSingleProvider.data!.productProvider![i];
   //   Log.i("productsGalleryWidget() - loop - m:  " + m.toString() );

      var item = ItemProductHorizontal( context, m );
      listWidget.add( item );
    }

    return Container(
      height: 235,
      child: ListView(scrollDirection: Axis.horizontal, children: listWidget ),
    );
  }



}
