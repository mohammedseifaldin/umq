import 'package:flutter/material.dart';
import 'package:umq/modules/auth/presentation/admin/logout/LogoutAdminPage.dart';
import 'package:umq/modules/cart/presentation/admin/list/v/OrderListAdminPage.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/v/DashboardPage.dart';
import 'package:umq/modules/home/presentation/home/HomePage.dart';
import 'package:umq/modules/notification/presentation/admin/list/v/NotificationListAdminPage.dart';
import 'package:umq/modules/place/presentation/admin/city/list/v/CityListAdminPage.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/v/OrgListAdminPage.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/modules/setting/presentation/admin/detail/v/SettingDetailAdminPage.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/SliderListAdminPage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/SubscribePackageListAdminPage.dart';
import 'package:umq/toolsUI/menuFullScreen/m/MItemSlide.dart';
import 'package:umq/toolsUI/menuFullScreen/v/ItemSlideWidget.dart';

class GenerateSlideForProject {
  static List<Widget> ListItemSlideWidget(BuildContext context) {
    List<Widget> listWidget = [];
    var listModel = GenerateSlideForProject.getScubaProjectItems(context);
    for (int i = 0; i < listModel.length; i++) {
      var m = listModel[i];
      var w = ItemSlideWidget(m);
      listWidget.add(w);
    }
    return listWidget;
    // return ColumnTemplate.t( children:  listWidget );
  }

  static List<MItemSlide> getScubaProjectItems(BuildContext context) {
    List<MItemSlide> list = [];
    list.add(_itemSlide_mobileAppStudent());
    list.add(_itemSlide_dashbaord());
    list.add(_itemSlide_user());
    list.add(_itemSlide_city());
    list.add(_itemSlide_org());
    list.add(_itemSlide_slide());
    list.add(_itemSlide_order());
    list.add(_itemSlide_notificationAdmin());
    list.add(_itemSlide_subscribePackage());
    list.add(_itemSlide_setting());
    list.add(_itemSlide_logout());

    return list;
  }

  //------------------------------------------------------------------- private

  static MItemSlide _itemSlide_dashbaord() {
    var m = MItemSlide(
        index: 0,
        title: "Dashboard",
        pageToOpen: DashboardPage(),
        iconData: Icons.dashboard_sharp);
    return m;
  }

  static MItemSlide _itemSlide_user() {
    var m = MItemSlide(
        index: 1,
        title: "Users",
        pageToOpen: const UserListAdminPage(),
        iconData: Icons.account_box_sharp);
    return m;
  }

  static MItemSlide _itemSlide_city() {
    var m = MItemSlide(
        index: 1,
        title: "Cities",
        pageToOpen: CityListAdminPage(),
        iconData: Icons.location_city_sharp);
    return m;
  }

  static MItemSlide _itemSlide_org() {
    var m = MItemSlide(
        index: 1,
        title: "Organization",
        pageToOpen: OrgListAdminPage(),
        iconData: Icons.real_estate_agent_sharp);
    return m;
  }

  static MItemSlide _itemSlide_slide() {
    var m = MItemSlide(
        index: 1,
        title: "Image Ads",
        pageToOpen: const SliderListAdminPage(),
        iconData: Icons.real_estate_agent_sharp);
    return m;
  }

  static MItemSlide _itemSlide_order() {
    var m = MItemSlide(
        index: 1,
        title: "Orders",
        pageToOpen: OrderListAdminPage(),
        iconData: Icons.real_estate_agent_sharp);
    return m;
  }

  static MItemSlide _itemSlide_notificationAdmin() {
    var m = MItemSlide(
        index: 1,
        title: "Notify", //Notifications
        pageToOpen: const NotificationListAdminPage(),
        iconData: Icons.real_estate_agent_sharp);
    return m;
  }

  static MItemSlide _itemSlide_subscribePackage() {
    var m = MItemSlide(
        index: 1,
        title: "Subscribe Package", //Notifications
        pageToOpen: const SubscribePackageListAdminPage(),
        iconData: Icons.subscript);
    return m;
  }

  static MItemSlide _itemSlide_setting() {
    var m = MItemSlide(
        index: 1,
        title: "Setting", //Notifications
        pageToOpen: SettingDetailAdminPage(),
        iconData: Icons.settings);
    return m;
  }

  static MItemSlide _itemSlide_logout() {
    var m = MItemSlide(
        index: 1,
        title: "Logout",
        pageToOpen: LogoutAdminPage(),
        iconData: Icons.logout);
    return m;
  }

  static MItemSlide _itemSlide_mobileAppStudent() {
    var m = MItemSlide(
        index: 1,
        title: "Student App",
        pageToOpen: const HomePage(),
        iconData: Icons.mobile_screen_share);
    return m;
  }
}
