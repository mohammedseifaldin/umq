
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/cart/data/response/ResponseCartCounter.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';

import 'package:umq/modules/product/presentation/customer/productDetails/c/ProductDetailController.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/v/cart_wedget.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/v/contact_widget.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/v/description_product.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/v/info_product.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/v/show_image_widget.dart';

import 'package:umq/toolsUI/scaffold/ScubaScaffoldSimple.dart';



class ProductDetailView extends StatefulWidget {

  int productId = 0 ;
  MProduct? mProduct;

  ProductDetailView({
    int? productId = 0,
    MProduct? mProduct,
}){
    this.productId = productId!;
    this.mProduct = mProduct;
  }

  @override
  ProductDetailState createState() {
    return ProductDetailState( productId: productId, mProduct: mProduct);
  }

}

class ProductDetailState extends ResumableState<ProductDetailView> {

  //--------------------------------------------------------------- variable

  MProduct? selectedProduct;
  ResponseCartCounter? cart;
  //int counter = 0;
  bool statusFaviorte = false ;

  ProgressCircleState? progressCircleState;

  int productId = 0 ;

  ProductDetailState({
    int? productId = 0,
    MProduct? mProduct,
  }){
    this.productId = productId!;
    this.selectedProduct = mProduct;
  }

  //--------------------------------------------------------------- life cycle

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    onResume();
  }

  @override
  void onResume() {
    // TODO: implement onResume
    super.onResume();

    if( selectedProduct == null ) {
      getSingleProduct( productId);
    }

  }

  //--------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {

    String title = 'Product Details';
    return ScubaScaffoldSimple( title, columnContent() );
  }


  Widget columnContent() {
    //check not found model, now download by id
    if( selectedProduct == null ) {
      return ProgressSpinkit.centerPage(context);
    }
   // return ProgressSpinkit.centerPage(context);
    return ColumnProduct();
  }


  Widget ColumnProduct() {
    return ListView(
      children: [
        SizedBox(
          height: 20,
        ),


       getShowImage(  ),
        SizedBox(
          height: 20,
        ),
        getInfoProduct(),

        getDescriptionProduct(),

        SizedBox(
          height: 20,
        ),

        getContactWidget(),
        SizedBox(
          height: 20,
        ),
        getCartWidget(),


        SizedBox(
          height: 60,
        ),


      ]
    );
  }

  
}