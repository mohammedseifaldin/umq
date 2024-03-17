
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/c/ProductDetailController.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';

import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/buttons/BlueBlurButtonScuba.dart';

extension CartWidget on ProductDetailState {



  Widget getCartWidget( ) {
    return selectedProduct == null
        ? const CircularProgressIndicator()
        : showCartWidget();
  }

  Widget showCartWidget() {
    return Container(
      padding: EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [

          EmptyView.empty(DeviceTools.getWidth(context), 50 ),

          //add to basket
          Container( child: bt_addToBasket(),
          margin: EdgeInsets.only(left: 10) ),


          //mines
          Positioned(right: 10, top: 0, bottom: 0, child: bt_minesView()),

          // coutner
          Positioned(
              right: 55,
              top: 0,
              bottom: 0,
              child: tv_counterCartView()

          ),

          //plus +
          Positioned(child: bt_plusView(), right: 90 , top: 0, bottom: 0,),


        ],
      ),
    );
  }

  //---------------------------------------------------------------- add to basket or plus +

  Widget bt_addToBasket() {
    String title =   'Add To Basket';
    return BlueBlurButtonScuba(title, 180, 50, (){
      postIncrement();
    });
  }

  Widget bt_plusView() {

    var icon = Icon(
      Icons.add,
      size: 30,
      color: Colors.blue.shade900,
    );

    var mat = Material( child:  icon , color:  Colors.transparent,);

    return GestureDetector(
      onTap: () {
        postIncrement( );
        selectedProduct!.cartCounter;
      },
      child: CircleAvatar(
        child: mat,
        radius: 25,
        backgroundColor: Colors.blue[300],
      ),
    );
  }

//----------------------------------------------------------------  mines -

  Widget bt_minesView() {
    var icon = Icon(
      Icons.remove,
      size: 30,
      color: Colors.white,
    );

    var mat = Material( child:  icon , color: Colors.transparent,);

    return GestureDetector(
      onTap: () {
        postDecrement( );

      },
      child: CircleAvatar(
        child: mat,
        backgroundColor: Colors.red,
        radius: 25,
      ),
    );
  }

  //-------------------------------------------------------------- counter cart

  Widget tv_counterCartView() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Text(
        '${selectedProduct!.cartCounter}',
        style: TextStyle(
          fontSize: 20,
            fontFamily: FontProject.beach,
            color: Colors.black,
            decoration: TextDecoration.none
        ),
      ),
    );
  }


}
