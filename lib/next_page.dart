import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';

import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/constant/EnvironmentConstant.dart';
import 'package:umq/toolsUI/html/editior/HtmlEditiorPage.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';
import 'package:umq/splash_screen.dart';

import 'tools/cache/constant_save.dart';

// next page after splash

extension NextPage on SplashScreenState {
  //---------------------------------------------------------------------------- launch page

  Future nextPage() async {
    if (EnvironmentConstant.isLive) {
      nextPageLive();
      return;
    } else {
      nextPageTest();
      return;
    }
  }

  Future<bool> isOpenWalkThrougBefore() async {
    final time = await Save.getString(ConstantSave.firstTimeOpenApp);
    return ToolsValidation.isEmpty(time);
  }

  Future nextPageLive() async {
    //-++++++++++++ Web : open admin directly
    /**
        if(  DeviceTools.isPlatformWeb() ) {
        GoToAdmin.loginPageAdmin( context);
        return;
        }
     */

    //-++++++++++++ first time open by mobile

    bool isFirstTime = await isOpenWalkThrougBefore();
    //Log.i( "nextPage() - localeName: " + localeName.toString() );
    if (isFirstTime) {
      /**
       set arabic app when setting is arabic
       */
      if (EnvironmentConstant.businessEnglishOnly == false) {
        LanguageTools.setArabicWhenDeviceLangaugeIsArabic(context);
      }

      GoTo.walkThrough(context);
      return;
    }

    //choose english in this part app
    if (EnvironmentConstant.businessEnglishOnly) {
      LanguageTools.setEnglish(context);
    }

    //
    // //check this stage show forever walck throug
    // if( EnvironmentConstant.business_walkthrough_forever ) {
    //   Log.i( "nextPageLive() - business_walkthrough_forever - yes" );
    //   GoTo.walkThrough(context);
    //   return;
    // }

    //check already login
    if (UserSingleTone.instance().isLogin()) {
      GoTo.chooseHomeByTypeRoleUser(context);
      return;
    }

    //guset go to walkthroug "like Uber" when make logout the ux go to walkthorug
    //GoTo.walkThrough(context);
    GoTo.homeStudent(context);
  }

  Future nextPageTest() async {
    //choose english in this part app
    if (EnvironmentConstant.businessEnglishOnly) {
      LanguageTools.setEnglish(context);
    }

    //------------------------------------------------------ treat as live

    // await nextPageLive();

    //--------------------------------------------------------- test langauge

    //test language
    //LanguageTools.setArabic( context);
    //LanguageTools.setEnglish( context);

    //---------------------------------------------------------- App : Mobile

    //+++++++++++++++++++++ auth

    // GoTo.splashLogin( context );
    GoTo.login(context);
    // GoTo.register_student(context,  "+20",  "1063499773");
    //mobileVerifyTest();
    // GoTo.registerChooseTypeUser(context);

    //+++++++++++++++++++++++ my account

    // GoTo.myAccountProfileShow(context);

    //++++++++++++++++++++++++ home

    // GoTo.walkThrough( context );
    //  GoTo.homeStudent(context);

    //++++++++++++++++++++ filter

    // GoTo.searchPage( context);

    //++++++++++++++++++++++ product

    //   GoTo.productDetail_byId(context, 1 );

    //+++++++++++++++++++++  provider detail
    // GoTo.providerDetail_by_id(context, 7);

    //++++++++++++++++++++++++ cart

    // GoTo.cartMain(context);
    //   GoTo.cartShipmentPage(context);
//      GoTo.cartPaymentMethod(context);

    //++++++++++++++++++++++++++ payment

    //   openPagePaymentOnline();

    //++++++++++++++++++++++++ menu pages

    // GoTo.notificationListPage(context);

    //-------------------------------------------------------------- App : Admin

    //++++++++++++++++++++++ login / dashboard / slide menu
    //  GoToAdmin.loginPageAdmin(context);
    // GoToAdmin.dashboard(context);
    //  GoToAdmin.menuFullPage(context);

    //+++++++++++++++++++++ pages
    // GoToAdmin.userList(context);
    //  GoToAdmin.userDetail_create(context, null );
    // GoToAdmin.cityList(context);
    // GoToAdmin.orgiizationList(context);
    // GoToAdmin.slideList( context );
    //   GoToAdmin.orderList(context);
    // GoToAdmin.notificationAdminList(context);
    // GoToAdmin.subscribePackageListAdmin(context   );
    // GoToAdmin.subscribePackageDetailAdmin(context, null,  this );
    // GoToAdmin.subscribeUsersListAdmin(context );

    /////// SETTING
    // GoToAdmin.settingAdmin(context);
    // openEditorHtmlTerms();

    //-------------------------------------------------------------- app : chat

    // GoTo.chatMainPage(context);
    // GoTo.chatSpecificUser(context,  16 );//16 //iphone is 77

    //navigate
    // var page = SimpleRecorder();
    // NavigationTools.push(context, page);
  }

  Future openPagePaymentOnline() async {
    String urlPaypalScuba = "https://scuba-world.net/paypal?price_target=1.0";
    String urlGoogle = "https://google.com";
    String umqApp = "https://umq.app";
    String scubaUrl = "https://scuba-world.net";
    String famousNodeJsWebsite = "https://www.netflix.com/eg/";
    String paypalNodeJsWebsite = "https://www.paypal.com";
    // var page = WebviewPaymentPage(url:  scubaUrl, urlChange: (updateUrl ){});
    // NavigationTools.push(context, page);

    GoTo.onlinePaymentPayPal(
        context: context,
        price: 1,
        callback: (bool status, String msg, String orderId) {
          Log.i("onlinePaymentPayPal() - status: $status /orderId: $orderId");

          if (status) {
            ToolsToast.i(context, "PayPal Success");
          } else {
            ToolsToast.i(context, "PayPal Payment Not Complete");
          }
        });
  }

  Future openEditorHtmlTerms() async {
    var page = HtmlEditiorPage(
        uniqueName: "terms",
        edit_url_content:
            "https://scubaworld.000webhostapp.com/scuba_laravel/storage/app/public/terms.html",
        callback: (result) {
          Log.i("openEditorHtmlTerms() - result: " + result);
        });
    NavigationTools.push(context, page);
  }

  // Future  mobileVerifyTest() async {
  //   GoTo.mobileVerifyGeneric(context, mobileToCheck: "+201063499772", callback:  (status, userIdFireabase){
  //       ToolsToast.i(context,  "Success " + userIdFireabase.toString() );
  //   });
  // }
}
