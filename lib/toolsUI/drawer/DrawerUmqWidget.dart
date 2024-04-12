import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/toolsUI/drawer/widgets/HeaderDrawer.dart';

class DrawerUmqWidget extends StatelessWidget {
  BuildContext? context;

  DrawerUmqWidget(this.context, {super.key});

  @override
  Widget build(BuildContext context) {
    this.context = context;

    return Container(
      color: HexColor(ColorProject.white_oxygen),
      width: 350,
      height: DeviceTools.getHeight(context),
      child: contentDrawer(),
    );
  }

  Widget contentDrawer() {
    return ColumnFastor(children: [
      header(),
    ]);
  }
}
