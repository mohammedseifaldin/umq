import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';

import 'package:umq/modules/cart/presentation/customer/main/v/MainCartPage.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/itemProduct/v/ItemProductCartView.dart';

extension CartProductListView on MainCartState {

  Widget getProductListView() {

    if( progress ) {
      return ProgressSpinkit.centerPage(context);
    }

    return _getListView();
  }


  Widget _getListView(){
    return ListViewTemplate.t(context: context,
        children: getItemProductCartListView(),
        axis: Axis.vertical);
  }


  List<Widget> getItemProductCartListView() {
    List<Widget> list = [];

    //check have data
    if( response == null ) return list ;
    if( response!.data == null ) return list;

    //loop
    int size = response!.data!.length;
    for( int i = 0 ; i < size ; i++ ) {
      MCartSingleProduct mCart = response!.data![i];
      Widget w = ItemProductCartView( this, mCart, i );
      list.add( w );
    }
    return list;
  }


}