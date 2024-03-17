import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/cart/data/response/ResponseCartProductList.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/MainCartController.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/CartProductListView.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/totalBar/v/TotalPriceBarView.dart';
import 'package:umq/tools/fcm/abdo/FCMRegister.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/buttons/ButtonLoginGuestView.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';

class MainCartPage extends StatefulWidget {
  const MainCartPage({super.key});

  @override
  MainCartState createState() {
    return MainCartState();
  }
}

class MainCartState extends ResumableState<MainCartPage> {
  //---------------------------------------------------------------------- variable

  ResponseCartProductList? response;

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

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await setupFcmFromMainPage(context);
    });
  }

  //---------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return PageTemplate.t(
      this,
      content: getContent(),

      //fixed background
      widgetBackground:
          BackgroundCardPage(toolbarHeight: ToolbarHomeScuba.frameHeight),

      //toolbar
      toolbar: ToolbarHomeScuba(context, title: "Cart"),
      toolbar_height: ToolbarHomeScuba.frameHeight,

      //navigation
      navigationBottom:
          NavigationBarButtonsScuba(context, EnumNavigationPage.cart),
      navigationBottom_height: NavigationBarButtonsScuba.frame_height,
    );
  }

  Widget getContent() {
    //check guest
    if (isGuest) {
      return ButtonLoginGuestView(context);
    }

    //show
    return ColumnTemplate.t(
        width: DeviceTools.getWidth(context),
        alignGravity: Alignment.topCenter,
        children: [
          getProductListView(),
          TotalPriceBarView(this),
        ]);
  }
}
