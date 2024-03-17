import 'package:flutter/material.dart';

import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'package:umq/modules/profile/presentation/customer/profileShow/v/profile_view.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/MainCartPage.dart';
import 'package:umq/modules/home/presentation/home/HomePage.dart';
import 'package:umq/modules/notification/presentation/customer/NotificationListPage/v/NotificationPage.dart';
import 'package:umq/modules/cart/provider/CartChangeNotifier.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/toolbarBackButton/ToolbarProjectBack.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/toolsUI/navigation/m/ModelNavigation.dart';

import 'package:umq/toolsUI/navigation/v/views/itemTab/ItemNavigationScuba.dart';

//colors
Color colorUnSelected = HexColor( ColorProject.greyDark );
Color colorSelected = HexColor( ColorProject.black_1 );
Color colorBackgroundNavigation = HexColor( ColorProject.blue_fish_front );
Color colorBoarderLine = HexColor( ColorProject.blueTransparent); //greyDark

int howManyButtonsInBar = 4;

class NavigationBarButtonsScuba extends StatefulWidget {



  //size
  static double frame_height = 70;
  double widthItemTab = 0; //will be calculated automatically

  //info
  BuildContext contextPage;
  EnumNavigationPage   enumNavigationPage; //here is the default button index



  NavigationBarButtonsScuba( this.contextPage, this.enumNavigationPage) ;

  @override
  NavigationBarButtonsScubaState createState() {
    return NavigationBarButtonsScubaState();
  }



}

class NavigationBarButtonsScubaState extends State<NavigationBarButtonsScuba> {


  @override
  void initState() {
    super.initState();
   CartChangeNotifier.getListenFalse(context).badgeCounterDownloadAfterValidate(context);
  }


  //-------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {

    calculateSize();
    return getCardViewForAllTabs();
  }

  void calculateSize(){
    widget.widthItemTab = DeviceTools.getWidth(context ) / howManyButtonsInBar;
  }


  //-------------------------------------------------------------------- cardview of all tabls


  Widget getCardViewForAllTabs() {
    var radius = BorderRadiusTools.get(
        radius_topLeft: DSDimen.ds_size_corner_level_1 ,
        radius_topRight: DSDimen.ds_size_corner_level_1
    );


    return BoarderHelper.cardViewPhysical(
      child:  rowTabs(),
      elevation_radius_value: 15,
      radiusBorder:  radius,
      colorBackground:  colorBackgroundNavigation,
     // colorLine: DataNavigationFastor.colorBoarderLine
    );
  }


  Widget rowTabs() {
    return RowScrollFastor(children:   [
      tabProfile(),
      tabHome(),
      tabCart(),
      tabNotification()
    ]);
  }


  Widget tabProfile(){
    var model =  ModelNavigation(
        enumNavigationPage: EnumNavigationPage.profile,
        title: "Profile",
        goToPage:  ProfileScreen(),
        iconData: Icons.person,
        badgeCounter:  0
    );

    return ItemNavigationScuba(
        contextPage: widget.contextPage,
        sizeTab: widget.widthItemTab,
        model: model,
        currentEnumNavigationPage: widget.enumNavigationPage
    );
  }


  Widget tabHome(){
    var model =  ModelNavigation(
        enumNavigationPage: EnumNavigationPage.home,
        title: "Home",
        goToPage:  HomePage(),
        iconData: Icons.home,
        badgeCounter:  0
    );

    return ItemNavigationScuba(
        contextPage: widget.contextPage,
        sizeTab: widget.widthItemTab,
        model: model,
        currentEnumNavigationPage: widget.enumNavigationPage
    );
  }


  Widget tabCart(){
    var badge = CartChangeNotifier.getListenTrue(context).getBadgeCounter();
    Log.i("NavigationBarButtonsScuba - tabCart() - badge: " + badge.toString());

    var model =  ModelNavigation(
        enumNavigationPage: EnumNavigationPage.cart,
        title: "Cart",
        goToPage:  MainCartPage(),
        iconData: Icons.shopping_basket,
        badgeCounter:  badge
    );

    return ItemNavigationScuba(
        contextPage: widget.contextPage,
        sizeTab: widget.widthItemTab,
        model: model,
        currentEnumNavigationPage: widget.enumNavigationPage
    );
  }


  Widget tabNotification(){
    var model =  ModelNavigation(
        enumNavigationPage: EnumNavigationPage.notification,
        title: "Notification",
        goToPage:  NotificationPage(),
        iconData: Icons.add_alert,
        badgeCounter:  0
    );

    return ItemNavigationScuba(
        contextPage: widget.contextPage,
        sizeTab: widget.widthItemTab,
        model: model,
        currentEnumNavigationPage: widget.enumNavigationPage
    );
  }



}


