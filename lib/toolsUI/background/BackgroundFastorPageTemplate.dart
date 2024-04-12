import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';

class BackgroundCardPage extends StatelessWidget {
  double toolbarHeight;

  BuildContext? context;

  BackgroundCardPage({super.key, required this.toolbarHeight});

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return colorBackgroundView();
  }

  Widget colorBackgroundView() {
    return Container(
      color: DSColor.ds_background_toolbar,
      child: cardShape(), //background //ColorProject.grey
    );
  }

  Widget cardShape() {
    return Container(
      width: DeviceTools.getWidth(context!),
      margin: EdgeInsets.only(top: toolbarHeight),
      decoration: BoxDecoration(
        color: HexColor(ColorProject.white_sun_4), //ColorProject.white_sun_4
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(DSDimen.space_level_2), //32
          topRight: Radius.circular(DSDimen.space_level_2),
        ),
      ),
      child: bodyPage(),
    );
  }

  Widget bodyPage() {
    /** ---- show background example
        return ImageViewTemplate(
        context: context!,
        opacity: 0.2,
        widthNeeded: DeviceTools.getWidth(context!),
        heightNeeded: DeviceTools.getHeight(context!),
        assetAspectRatio: DrawableProject.exampleMobile( "IMG_8510"),
        );
     */

    return EmptyView.allDeviceScreen(context!);
  }
}
