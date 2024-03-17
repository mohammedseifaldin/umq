import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/home/presentation/home/slideTop/SlideTop.dart';
import 'package:umq/modules/home/presentation/home/slideTop/slideManager.dart';
import 'package:umq/modules/home/provider/HomeChangeNotifier.dart';
import 'package:umq/modules/home/provider/HomeNotifier.dart';
import 'package:umq/modules/home/provider/get_categories_notifier.dart';
import 'package:umq/tools/fcm/abdo/FCMRegister.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/toolsUI/background/BackgroundFastorPageTemplate.dart';
import 'package:umq/toolsUI/itemList/category/category_view.dart';
import 'package:umq/toolsUI/itemList/provider/ItemProviderHomeVertical.dart';
import 'package:umq/toolsUI/navigation/m/EnumNavigationPage.dart';
import 'package:umq/toolsUI/navigation/v/NavigationScuba.dart';
import 'package:umq/toolsUI/toolbarHome/ToolbarHomeScuba.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends ResumableState<HomePage> {
  //--------------------------------------------------------------------- variable

  late HomeChangeNotifier provider;

  //---------------------------------------------------------------------- life style

  @override
  void onReady() {
    super.onReady();
    Log.i("WalkThroughPage - onReady()");
    onResume();
  }

  @override
  void initState() {
    super.initState();
    provider = HomeChangeNotifier.getListenFalse(context);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await setupFcmFromMainPage(context);
      provider.downloadFirstPage(context);
      provider.setupScrollListenerToPaginate(context);
      provider.getCategories(context);
    });
  }

  //------------------------------------------------------------------------------ build

  @override
  Widget build(BuildContext context) {
    provider = HomeChangeNotifier.getListenTrue(context);

    //init values
    calculateFrameSlide(context);

    return PageFastor(
      this,
      content: getContent(),
      // isPlaceBodyInsideScroll: true,
      // stateFullWidget: this,
      // resizeToAvoidBottomInset: false,
      scrollController: provider.homeScrollController,

      //fixed background
      widgetBackground:
          BackgroundCardPage(toolbarHeight: ToolbarHomeScuba.frameHeight),

      //toolbar
      toolbar: ToolbarHomeScuba(context, title: "Home"),
      toolbar_height: ToolbarHomeScuba.frameHeight,

      //navigation
      navigationBottom:
          NavigationBarButtonsScuba(context, EnumNavigationPage.home),
      navigationBottom_height: NavigationBarButtonsScuba.frame_height,
      title: "Home",
    );
  }

  //------------------------------------------------------------------------------ card background

  Widget getContent() {
    return paginatePageWidget();
  }

  //------------------------------------------------------------------------------ paginate

  Widget paginatePageWidget() {
    var listChildren = allItemInHomePage();
    return ListViewTemplate.t(
        context: context, children: listChildren, axis: Axis.vertical);
  }

  //---------------------------------------------------------------------  content of screen

  List<Widget> allItemInHomePage() {
    List<Widget> ls = [];
    ls.add(getSliderTopToBeAddedToContentOfScreen());
    ls.addAll(listWidgetCategories());
    // ls.addAll(listWidgetTeacher());
    ls.add(progressViewIfNeeded());
    ls.add(allDataDownloaded());
    return ls;
  }

  Widget getSliderTopToBeAddedToContentOfScreen() {
    return getHomeSlider();
  }

  //--------------------------------------------------------------------- teahcer views

  List<Widget> listWidgetTeacher() {
    List<Widget> listWidget = [];
    for (int i = 0; i < provider.teachers.length; i++) {
      Widget w = itemOfHomePage(i);
      listWidget.add(w);
    }
    Log.i("listWidgetTeacher() - listWidget: ${listWidget.length}");
    return listWidget;
  }

  List<Widget> listWidgetCategories() {
    return List.generate(
      provider.categories.length,
      (index) => CategoryView(
        category: provider.categories[index],
      ),
    );
  }

  Widget itemOfHomePage(int position) {
    return ItemProviderHomeVertical(context,
        provider: provider.teachers[position]);
  }

  //---------------------------------------------------------------------- progress and allDataDownloaded

  Widget progressViewIfNeeded() {
    if (provider.homeProgress == false) return const SizedBox();
    return Container(
      alignment: Alignment.center,
      width: DeviceTools.getWidth(context),
      child: ProgressCircleFastor(),
    );
  }

  Widget allDataDownloaded() {
    if (provider.allDataAdded == false) return const SizedBox();
    var txt = TextFastor(
      "All Data Downloaded",
      color: HexColor(ColorProject.black_1),
      fontSize: 15,
      fontFamily: FontProject.beach,
    );
    return Container(
      alignment: Alignment.center,
      width: DeviceTools.getWidth(context),
      child: txt,
    );
  }
}
