import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/auth/provider/AuthChangeNotifier.dart';
import 'package:umq/modules/category_products/provider/category_products_notifier.dart';
import 'package:umq/modules/home/provider/HomeChangeNotifier.dart';
import 'package:umq/modules/cart/provider/CartChangeNotifier.dart';
import 'package:umq/modules/product_detail/provider/product_details_notifier.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';
import 'package:umq/tools/fastor/ds/DesignSystemFastor.dart';
import 'package:umq/toolsUI/scroll/MyScrollTheme.dart';
import 'firebase_options.dart';
import 'package:flutter/material.dart' if (dart.library.html) 'dart:html';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'tools/cache/user_single_tone.dart';
import 'tools/constant/EnvironmentConstant.dart';
import 'splash_screen.dart';

FirebaseAnalytics analytics = FirebaseAnalytics.instance;
FirebaseAnalyticsObserver observer =
    FirebaseAnalyticsObserver(analytics: analytics);

//---------------------------  main full option

void main() async {
  //ui wait
  WidgetsFlutterBinding.ensureInitialized();

  //translation
  // await EasyLocalization.ensureInitialized();
  await LanguageTools.instance();

  //firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // await FCMRegister().initializeApp();
  await SaveFastor.init();
  UserSingleTone.instance();

  //fastor color
  DesignSystemFastor.ensureInitialized();

  //run
  runApp(multiProviderWithMyApp());
}

//----------------------------------------------------------------------- provider

Widget multiProviderWithMyApp() {
  return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: AuthChangeNotifier()),
        ChangeNotifierProvider.value(value: HomeChangeNotifier()),
        ChangeNotifierProvider.value(value: CartChangeNotifier()),
        ChangeNotifierProvider.value(value: SubscribeChangeNotifier()),
        ChangeNotifierProvider.value(value: CategoryProductsNotifier()),
        ChangeNotifierProvider.value(value: ProductDetailsNotifier()),
      ],
      builder: (context, widget) {
        return const MyApp();
      });
}

//------------------------------------------------------------------ my app

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //language translation
      //   locale: context.locale,
      //   supportedLocales: context.supportedLocales,
      //   localizationsDelegates: context.localizationDelegates,
      title: EnvironmentConstant.appName,
      navigatorObservers: <NavigatorObserver>[observer],
      // navigatorObservers: <RouteObserver<ModalRoute<void>>>[ routeObserver ],
      //
      color: StatusBarConstant.colorBackground, //Colors.green
      debugShowCheckedModeBanner: false,
      //scroll shadow : remove glow of scroll bar
      scrollBehavior: MyScrollTheme(),

      // language direction RTL or LTR
      home: Directionality(
        // add this
        textDirection: LanguageTools.getTextDirection(context),
        child: const Scaffold(
          body: SplashScreen(),
          // resizeToAvoidBottomInset: true , //fix keyboard when open
        ),
      ),
    );
  }
}
