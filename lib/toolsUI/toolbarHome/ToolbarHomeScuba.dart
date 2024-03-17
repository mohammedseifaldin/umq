import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/navigate/GoToAdmin.dart';
import 'package:umq/tools/navigate/GoTo.dart';
import 'package:umq/tools/cache/user_single_tone.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/resourceProject/DrawableProject.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';

class ToolbarHomeScuba extends StatelessWidget {
  static double heightTopRow = 50.0;
  // static double heightBottomRow = 15.0;
  static double frameHeight = heightTopRow;

  BuildContext contextPage;
  String title;

  ToolbarHomeScuba(this.contextPage, {required this.title});

  @override
  Widget build(BuildContext context) {
    return toolbarHome();
  }

  Widget toolbarHome() {
    var stack = Stack(children: [
      //height of all toolbar
      EmptyView.empty(
          DeviceTools.getWidth(contextPage), ToolbarHomeScuba.frameHeight),

      //color to row
      EmptyView.colored(DeviceTools.getWidth(contextPage),
          ToolbarHomeScuba.heightTopRow, DSColor.ds_background_toolbar),

      //console
      Positioned(child: bt_console(), top: 10),

      // title
      Positioned(child: toolbarTitle(), left: 0, right: 0, top: 10),

      //buttons right
      Positioned(child: rightButtonToolbar(), right: 0, top: 0),
    ]);
    return stack;
  }

  //--------------------------------------------------------------------- Top toolbar
  bool isConsoleButtonVisible = false;

  Widget bt_console() {
    //check not have console
    isConsoleButtonVisible =
        UserSingleTone.instance().isAdminOrProviderNoWait();
    // Log.i("bt_console() - isConsoleButtonVisible: " + isConsoleButtonVisible.toString() );

    if (isConsoleButtonVisible == false) {
      return EmptyView.zero();
    }

    //show
    return TextFastor(
      "console",
      onPressed: () {
        //choose type
        GoTo.chooseHomeByTypeRoleUser(contextPage);
      },
      width: 60,
      height: 25,
      fontSize: 15,
      gravityLayoutAlign: Alignment.center,
      levelDS: LevelDS.l4,
      fontFamily: FontProject.marina,
      margin: EdgeInsets.only(left: DSDimen.space_level_2),
      //backgroundColor: HexColor( ColorProject.greyDark),
      decoration: BoarderHelper.cardViewShadow(
          colorBackground: HexColor(ColorProject.greyDark), radiusSize: 15),
      color: HexColor(ColorProject.black_1),
    );
  }

  Widget toolbarTitle() {
    return TextTemplate.t(title,
        color: HexColor(ColorProject.black_1), levelDS: LevelDS.parent,fontFamily: "LifesABeach-gAo5.ttf");
  }

  Widget rightButtonToolbar() {
    return RowTemplate.wrapChildren(getListButtonToolbar());
  }

  List<Widget> getListButtonToolbar() {
    return [
      im_search(),
      SizedBox(
        width: 10,
      ),
      im_chatMainPage()
    ];
  }

  Widget im_chatMainPage() {
    return IconButton(
        onPressed: () {
          GoTo.chatMainPage(contextPage);
        },
        icon: Icon(
          Icons.chat,
          color: Colors.black,
        ));
  }

  Widget im_search() {
    var image = DrawableProject.images("search_black_en");
    if (LanguageTools.isArabic(contextPage)) {
      image = DrawableProject.images("search_black_ar");
    }

    return ImageView(
      width: 25,
      height: 25,
      assetAspectRatio: image,
      onPressed: () {
        GoTo.searchPage(contextPage);
      },
    );
  }
}
