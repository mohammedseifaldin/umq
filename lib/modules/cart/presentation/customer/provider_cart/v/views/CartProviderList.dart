import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/provider_cart/v/CartProviderScreen.dart';
import 'package:umq/toolsUI/itemList/provider/ItemProviderHomeVertical.dart';

extension CartProviderList on CartProviderState {

  Widget getProviderListView() {

    if( progress ) {
      return ProgressSpinkit.get();
    }


    if( response == null  ) {
      return ProgressSpinkit.get();
    }
    if( response!.data == null  ) {
      return ProgressSpinkit.get();
    }
    if( response!.data!.length == 0  ) {
      return TextFastor( "Empty Data");
    }

    return _getListView();
  }


  Widget _getListView(){
    return ListViewTemplate.t(context: context,
        children: getItemProviderCartListView(),
        axis: Axis.vertical);
  }


  List<Widget>   getItemProviderCartListView(){
    List<Widget> listWidget = [];
    for( int i = 0; i < response!.data!.length; i++ ) {
      Widget w = itemOfCartProviderPage(i);
      listWidget.add( w );
    }
    return listWidget;
  }


  Widget itemOfCartProviderPage(int position){
    return  ItemProviderHomeVertical( context, provider: response!.data![position]) ;
  }

}