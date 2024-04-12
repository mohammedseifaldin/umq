import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/toast/ToastTools.dart';

class ItemDashboardAnalyticsCounterWidget extends StatelessWidget {
  String title;
  int? counter;
  IconData icon;
  Widget? pageGoTo;
  BuildContext? context;

  ItemDashboardAnalyticsCounterWidget({
    super.key,
    required this.title,
    required this.counter,
    required this.icon,
    required this.pageGoTo,
  });

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return CardViewTemplate.t(
        child: getContent(),
        colorBoarderLine: HexColor(ColorProject.blue_fish_back),
        shadowColor: HexColor(ColorProject.blue_fish_back),
        elevationValue: 10,
        radius_all: 10,
        width: getFrameWidthResponsive(),
        height: getFrameWidthResponsive());
  }

  Widget getContent() {
    var col = ColumnFastor(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        colorBackground: HexColor(ColorProject.blueTransparent_fish_front),
        children: [iconWidget(), tvCounterValue(), tvTitle()]);

    return GestureDetector(
        child: col,
        onTap: () {
          if (pageGoTo == null) {
            ToolsToast.i(context!, "Under Development");
            return;
          }
          NavigationTools.pushAndRemoveUntil(context!, pageGoTo!);
        });
  }

  Widget iconWidget() {
    var ic =
        Icon(icon, size: 30, color: HexColor(ColorProject.blue_fish_front));
    return ic;
  }

  Widget tvTitle() {
    return TextFastor(
      title,
      color: HexColor(ColorProject.blue_fish_front),
    );
  }

  Widget tvCounterValue() {
    return TextFastor(
      "$counter",
      color: HexColor(ColorProject.yellow_3), //ColorProject.yellow_3
    );
  }

  double getIconWidthResponsive() {
    return 30;
  }

  double getFrameWidthResponsive() {
    if (DeviceTools.isPortrait(context!)) {
      return DeviceTools.getThirdWidth(context!);
    } else {
      return DeviceTools.getSixthWidth(context!);
    }
  }
}
