import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/cart/data/model/MOrder.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/OrderDetailAdminPage.dart';
import 'package:umq/modules/cart/presentation/admin/list/v/OrderListAdminPage.dart';
import 'package:umq/modules/dashboard/presentation/admin/dashboard/v/DashboardPage.dart';
import 'package:umq/modules/home/data/model/MSlider.dart';
import 'package:umq/modules/notification/presentation/admin/detail/v/NotificationCreateAdminPage.dart';
import 'package:umq/modules/notification/presentation/admin/list/v/NotificationListAdminPage.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/place/presentation/admin/city/detail/v/CityDetailAdminPage.dart';
import 'package:umq/modules/place/presentation/admin/city/list/v/CityListAdminPage.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/detail/v/OrgDetailAdminPage.dart';
import 'package:umq/modules/profile/presentation/admin/orginization/list/v/OrgListAdminPage.dart';
import 'package:umq/modules/profile/presentation/admin/user/detail/v/UserDetailAdminPage.dart';
import 'package:umq/modules/profile/presentation/admin/user/list/v/UserListAdminPage.dart';
import 'package:umq/modules/setting/presentation/admin/detail/v/SettingDetailAdminPage.dart';
import 'package:umq/modules/setting/presentation/admin/slider/detail/v/SliderDetailAdminPage.dart';
import 'package:umq/modules/setting/presentation/admin/slider/list/v/SliderListAdminPage.dart';
import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_detail/SubscribePackageDetailAdminPage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_list/SubscribePackageListAdminPage.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_detail/SubscribeUserByAdminPage.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_list/SubscribeUsersListAdminPage.dart';
import 'package:umq/toolsUI/admin/menu/GenerateSlideForProject.dart';
import 'package:umq/toolsUI/admin/picker/user/PickerUserPage.dart';
import 'package:umq/toolsUI/menuFullScreen/m/MItemSlide.dart';
import 'package:umq/toolsUI/menuFullScreen/v/MenuFullPageWidget.dart';

class GoToAdmin {
  //------------------------------------------------------------------- login / dashboard

  static void dashboard(BuildContext context) {
    // userList(context);
    NavigationTools.pushAndRemoveUntil(context, DashboardPage());
  }

  //--------------------------------------------------------------------------- menu

  static void menuFullPage(BuildContext context) {
    List<MItemSlide> listSlide =
        GenerateSlideForProject.getScubaProjectItems(context);
    var page = MenuFullPageWidget(listSlide: listSlide);
    var transparent = PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => page,
    );
    Navigator.push(context, transparent);
  }

  //------------------------------------------------------------------- user

  static void userList(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, const UserListAdminPage());
  }

  static void userDetail_edit(
      BuildContext context, MUser mEdit, ResumableState resume) {
    NavigationTools.pushResume(
        context, UserDetailAdminPage(edit: mEdit), resume);
  }

  static void userDetail_create(BuildContext context, ResumableState? resume) {
    var w = UserDetailAdminPage();
    // var w = SignUpPage();
    Log.i("userDetail_create() ");
    if (resume != null) {
      NavigationTools.pushResume(context, w, resume);
    } else {
      NavigationTools.push(context, w);
    }
  }

  static void pickerUser(BuildContext context, ResumableState? resume,
      {required ValueChanged<MUser> select}) {
    var w = PickerUserPage(select);
    if (resume != null) {
      NavigationTools.pushResume(context, w, resume);
    } else {
      NavigationTools.push(context, w);
    }
  }

  //-------------------------------------------------------------------- city

  static void cityList(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, CityListAdminPage());
  }

  static void cityDetail_edit(
      BuildContext context, MCity mEdit, ResumableState resume) {
    NavigationTools.pushResume(
        context, CityDetailAdminPage(edit: mEdit), resume);
  }

  //----------------------------------------------------------------- orginization

  static void orgiizationList(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, OrgListAdminPage());
  }

  static void orgiizationDetail_edit(
      BuildContext context, MOrganization mEdit, ResumableState resume) {
    NavigationTools.pushResume(
        context, OrgDetailAdminPage(edit: mEdit), resume);
  }

  //----------------------------------------------------------------- slide

  static void slideDetail_edit(
      BuildContext context, MSlider mEdit, ResumableState resume) {
    NavigationTools.pushResume(
        context, SlideDetailAdminPage(edit: mEdit), resume);
  }

  static void slideList(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, const SliderListAdminPage());
  }

  //-------------------------------------------------------------------- order

  static void orderList(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, OrderListAdminPage());
  }

  static void orderDetail_edit(
      BuildContext context, MOrder mEdit, ResumableState resume) {
    NavigationTools.pushResume(context, OrderDetailAdminPage(mEdit), resume);
  }

//-------------------------------------------------------------------- notification

  static void notificationAdminList(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(
        context, const NotificationListAdminPage());
  }

  static void notificationAdminDetail_create(
      BuildContext context, ResumableState resume) {
    NavigationTools.pushResume(context, NotificationCreateAdminPage(), resume);
  }

  //-------------------------------------------------------------------- setting

  static void settingAdmin(BuildContext context) {
    var w = SettingDetailAdminPage();
    NavigationTools.pushAndRemoveUntil(context, w);
  }

  //-------------------------------------------------------------------- subscribe

  static void subscribePackageListAdmin(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(
        context, const SubscribePackageListAdminPage());
  }

  static void subscribePackageDetailAdmin(
      BuildContext context, MSubscribePackage? mEdit, ResumableState resume) {
    NavigationTools.pushResume(
        context, SubscribePackageDetailAdminPage(mEdit: mEdit), resume);
  }

  static void subscribeUsersListAdmin(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, SubscribeUsersListAdminPage());
  }

  static void subscribeUserByAdmin(
      BuildContext context, ResumableState resume) {
    NavigationTools.pushResume(context, SubscribeUserByAdminPage(), resume);
  }
}
