import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/teachers/data/response/ResponseListTeacher.dart';
import 'package:umq/modules/cart/presentation/customer/provider_cart/c/CartProviderController.dart';
import 'package:umq/modules/cart/presentation/customer/provider_cart/v/views/CartProviderList.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';

@Deprecated( "not need")
class CartProviderScreen extends StatefulWidget {

  @override
  CartProviderState createState() => CartProviderState();

}

class CartProviderState extends    ResumableState<CartProviderScreen > {

//---------------------------------------------------------------------- variable

  ResponseListProvider? response;

bool progress = false;

bool isGuest = false;

//---------------------------------------------------------------------- life style

@override
void onReady() {
  super.onReady();
  onResume();
}

@override
void onResume() {
  super.onResume();
  getCartListApi();
}


@override
void initState() {
  super.initState();
}

//---------------------------------------------------------------------- build

@override
Widget build(BuildContext context) {
  return PageTemplate.t( this ,
    content: getContent(),

    //fixed background
    widgetBackground: BackgroundCardPage( toolbarHeight: ToolbarHomeScuba.frameHeight ),

    //toolbar
    toolbar: ToolbarHomeScuba( context , title: "Cart For All Providers" ),
    toolbar_height: ToolbarHomeScuba.frameHeight   ,


    //navigation
    navigationBottom: NavigationBarButtonsScuba( context, EnumNavigationPage.cart ),
    navigationBottom_height: NavigationBarButtonsScuba.frame_height ,
  );
}

Widget getContent() {
  return ColumnTemplate.t(
      width: DeviceTools.getWidth(context),
      alignGravity: Alignment.topCenter  ,
      children: [
        getProviderListView()

      ]);
}


}
