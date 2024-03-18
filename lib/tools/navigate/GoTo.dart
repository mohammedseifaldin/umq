import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart' hide SearchController;
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/auth/presentation/customer/BecomeTeacher/BecomeTeacherPage.dart';
import 'package:umq/modules/auth/presentation/customer/CompleteRegisterStudent/RegisterStudentPage.dart';
import 'package:umq/modules/auth/presentation/customer/Login/login_page.dart';
import 'package:umq/modules/auth/presentation/customer/MobileVerification/SignWithMobilePage.dart';
import 'package:umq/modules/auth/presentation/customer/UserType/user_type_page.dart';
import 'package:umq/modules/auth/presentation/customer/register_student/register_student_with_emailpage.dart';
import 'package:umq/modules/auth/presentation/customer/splashLogin/SplashLoginPage.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/MainCartPage.dart';
import 'package:umq/modules/cart/presentation/customer/payment_method/v/CartPaymentMethodPage.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/CartReceiptPage.dart';
import 'package:umq/modules/cart/presentation/customer/shipping/v/CartShipmentPage.dart';
import 'package:umq/modules/category_products/presintation/category_products_screen.dart';
import 'package:umq/modules/chat/shared/toolsChat/route/ChatRoute.dart';
import 'package:umq/modules/home/presentation/WalkThroughPage/WalkThroughPage.dart';
import 'package:umq/modules/home/presentation/home/HomePage.dart';
import 'package:umq/modules/notification/presentation/customer/NotificationListPage/v/NotificationPage.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/product/presentation/customer/productDetails/view/ProductDetailView.dart';
import 'package:umq/modules/product_detail/presintation/view/product_details_screen.dart';
import 'package:umq/modules/profile/presentation/customer/profileEdit/v/edit_screen.dart';
import 'package:umq/modules/profile/presentation/customer/profileShow/m/ResponseSingleUser.dart';
import 'package:umq/modules/search/presentation/customer/result_product/ProductSearchResultPage.dart';
import 'package:umq/modules/search/presentation/customer/result_teacher/TeacherSearchResultPage.dart';
import 'package:umq/modules/search/presentation/customer/search_any/search_controller.dart';
import 'package:umq/modules/search/presentation/customer/search_any/search_page.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/modules/teachers/presentation/customer/detail/TeacherDetailsPage.dart';
import 'package:umq/splash_screen.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/toolsUI/ImageFullScreen/ImageFullScreen.dart';
import 'package:umq/toolsUI/paypal/visa_guest_or_paypal/PaypalGenericPage.dart';
import 'package:umq/toolsUI/rateDialog/RateProviderDialog.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';
import 'package:umq/toolsUI/video/VideoPageFullScreen.dart';

class GoTo {
  static String tag = "GoTo";

  //---------------------------------------------------------------- splash and  WalkThroughPage

  static splashApp(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, const SplashScreen());
  }

  static void walkThrough(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, WalkThroughPage());
  }

  //-------------------------------------------------------------------- home

  static Future chooseHomeByTypeRoleUser(BuildContext context) async {
    //admin
    if (await UserSingleTone.instance().isRoleAdmin()) {
      GoToAdmin.dashboard(context);
      return;
    }

    //student
    if (await UserSingleTone.instance().isRoleStudent()) {
      GoTo.homeStudent(context);
      return;
    }

    //provider
    if (await UserSingleTone.instance().isRoleProvider()) {
      GoTo.homeProvider(context);
      return;
    }

    //default
    GoTo.homeStudent(context);
  }

  static void homeAdmin(BuildContext context) {
    GoToAdmin.dashboard(context);
  }

  static void homeStudent(BuildContext context) {
    Log.k(tag, "homeStudent()");

    // NavigationTools.pushAndRemoveUntil( context,  NavigationBarProject( ) );
    NavigationTools.pushAndRemoveUntil(context, const HomePage());
  }

  static void homeProvider(BuildContext context) {
    GoTo.homeStudent(context);
  }

  //------------------------------------------------------------------ auth

  static void splashLogin(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, SplashLoginPage());
  }

  static void login(BuildContext context) {
    NavigationTools.pushAndRemoveUntil(context, const LoginMobilePage());
  }

  // static void mobileVerifyGeneric(BuildContext context,
  //     {required SignToOtpFirebaseCallBack callback,
  //     required String mobileToCheck}) {
  //   NavigationTools.push(
  //     context,
  //     SignWithMobilePage(
  //       callback,
  //       mobile: mobileToCheck,
  //     ),
  //   );
  // }

  static void registerStudent(
      BuildContext context, String country, String phone) {
    // Log.i( "register_student() - country: " + country + " /phone: " + phone );
    Widget w = RegisterStudentPage(country + phone);
    NavigationTools.push(context, w);
  }

  static void registerStudentWithEmail({required BuildContext context}) {
    NavigationTools.push(context, const RegisterStudentWithEmailPage());
  }

  static void registerChooseTypeUser(BuildContext context) {
    NavigationTools.push(context, UserTypePage());
  }

  static void becomeTeacher(BuildContext context) {
    NavigationTools.push(context, BecomeTeacherPage());
  }

  //------------------------------------------------------------------- my account

  static void myAccountProfileShow(BuildContext context) {
    // NavigationTools.push(context, ProfileScreen() );

    GoTo.homeStudent(context);
  }

  static void myAccountProfileEdit(BuildContext context, ResumableState resume,
      ResponseSingleUser responseSingleUser) {
    NavigationTools.pushResume(
        context, EditScreen(response: responseSingleUser), resume);
  }

  //------------------------------------------------------------------------ search filter

  static void searchPage(BuildContext context) {
    NavigationTools.push(context, SearchPage());
  }

  static void resultFilterProvider(
      BuildContext context, SearchScreenController con) {
    var w = ProviderSearchResultPage(con);
    NavigationTools.push(context, w);
  }

  static void resultFilterProduct(
      BuildContext context, SearchScreenController con) {
    var w = ProductSearchResultPage(context, con);
    NavigationTools.push(context, w);
  }

  //------------------------------------------------------------------------ details

  static void productDetail_byId(BuildContext context, int id) {
    Log.i("GoTo - productDetail_byId() - id: $id");
    var w = ProductDetailView(productId: id);
    NavigationTools.push(context, w);
  }

  static void productDetailById(BuildContext context, int id) {
    Log.i("GoTo - product_details_screen_byId() - id: $id");
    var w = ProductDetailsScreen(productId: id);
    NavigationTools.push(context, w);
  }

  static void categoryProductsById(BuildContext context, int id) {
    Log.i("GoTo - productDetail_byId() - id: $id");
    var w = CategoryProductsScreen(categoryId: id);
    NavigationTools.push(context, w);
  }

  static void productDetail(BuildContext context, MProduct m) {
    Log.i("GoTo - productDetail() - id: " + m.id.toString());
    var w = ProductDetailView(mProduct: m);
    NavigationTools.push(context, w);
  }

  static void providerDetail(BuildContext context, MProvider m) {
    // Log.i( "providerDetail() -context " + context.toString() );
    Log.i("GoTo - providerDetail() - id: " + m.id.toString());
    var w = ProviderDetailsPage(provider: m);
    NavigationTools.push(context, w);
  }

  static void providerDetail_by_id(BuildContext context, int providerId) {
    // Log.i( "providerDetail_by_id() -context " + context.toString() );
    // Log.i( "providerDetail() " + m.toString() );

    var w = ProviderDetailsPage(providerId: providerId);
    NavigationTools.push(context, w);
  }

  //---------------------------------------------------------------------- chat

  static void chatMainPage(BuildContext context) {
    Log.k(tag, "chatMainPage()");
    ChatRouteGoTo.userList_pushAndRemove(context);
  }

  static void chatSpecificUser(BuildContext context, int targetUserId) {
    Log.k(tag, "chatSpecificUser() - targetUserId: $targetUserId");
    ChatRouteGoTo.specificUser_openFromOutside(context, targetUserId);
  }

  static void chatSpecificUser_resume(
      BuildContext context, ResumableState resume, int targetUserId) {
    Log.k(tag, "chatSpecificUser_resume() - targetUserId: $targetUserId");
    ChatRouteGoTo.specificUser_openFromOutside_resume(
        context, resume, targetUserId);
  }

  //--------------------------------------------------------------------- gallery

  static void fullScreenImage(BuildContext context, String imageUrl) {
    var w = ImageFullScreen(imageUrl: imageUrl);
    NavigationTools.push(context, w);
  }

  static void videoFullScreen(BuildContext pageContext, String videoUrl) {
    Navigator.of(pageContext).push(MaterialPageRoute(
        builder: (context) => VideoPageFullScreen(
              videoSrc: videoUrl,
            )));
  }

  //--------------------------------------------------------------------- rate

  static void rateDialog(
      BuildContext context, MProvider mProvider, ResumableState resume) {
    //  Log.i( "rateDialog() - 3 ");
    Widget page = RateProviderDialog(context, mProvider);
    var transparent = PageRouteBuilder(
      opaque: false,
      pageBuilder: (_, __, ___) => page,
    );
    resume.push(context, transparent);
  }

  //---------------------------------------------------------------------- cart

  static void cartMain(BuildContext context) {
    NavigationTools.push(context, const MainCartPage());
  }

  // static void cartProvider(BuildContext context ) {
  //   NavigationTools.push(context, CartProviderScreen() );
  // }

  static void cartShipmentPage(BuildContext context) {
    NavigationTools.push(context, CartShipmentPage());
  }

  static void cartPaymentMethod(BuildContext context) {
    Log.i("GoTo - cartPaymentMethod");
    NavigationTools.push(context, const CartPaymentMethodPage());
  }

  static void cartReceiptPage(BuildContext context) {
    NavigationTools.push(context, CartReceiptPage());
  }

  //----------------------------------------------------------------- sub menu pages

  static void notificationListPage(BuildContext context) {
    NavigationTools.push(context, NotificationPage());
  }

  static void favoritePage(BuildContext context) {
    GoTo.homeStudent(context);
  }

  //----------------------------------------------------------------------- payment online

  static void onlinePaymentPayPal(
      {required BuildContext context,
      required double price,
      required PaypalCallBack callback}) {
    // ToolsToast.i(context, "PayPal Payment Under Development");
    var page = PaypalGenericPage(
      price: price,
      payPalCallBack: callback,
    );
    NavigationTools.push(context, page);
  }

  static void onlinePaymentMyFatoorah(BuildContext context) {
    ToolsToast.i(context, "MyFatoorah Payment Under Development");
  }
}
