import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';
import 'package:umq/modules/subscribe/data/request/RequestCreateSubscribePackage.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_detail/logic/EditData.dart';
import 'package:umq/modules/subscribe/presentation/admin/package_detail/widget/ContentUserDetail.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';

class SubscribePackageDetailAdminPage extends StatefulWidget {
  MSubscribePackage? mEdit;

  SubscribePackageDetailAdminPage({super.key, this.mEdit});

  @override
  SubscribePackageDetailAdminState createState() {
    return SubscribePackageDetailAdminState();
  }
}

class SubscribePackageDetailAdminState
    extends ResumableState<SubscribePackageDetailAdminPage> {
  //-------------------------------------------------------------------- variable
  String pageTitle = "Package";

  SubscribeChangeNotifier? provider;
  var request = RequestCreateSubscribePackage();

  //------------------------------------------------------------------- life cycle

  @override
  void initState() {
    super.initState();
    setEditDataIfFound();
  }

  @override
  void onReady() {
    super.onReady();
    onResume();
  }

  @override
  void onResume() {
    super.onResume();
    Log.i("lifecycle - onResume - $pageTitle");
  }

  //-------------------------------------------------------------------- build

  BuildContext? contextPage;

  @override
  Widget build(BuildContext context) {
    contextPage = context;
    provider = SubscribeChangeNotifier.getListenFalse(context);

    return PageFastor(
      this,
      title: getTitleText(),
      statusBarColorCustom: HexColor(ColorProject.black_4),
      content: pageResponsiveWebOrMobile(),
      toolbar: ToolbarSimpleFastor(contextPage!, pageTitle,
          iconColorBack: Colors.black),
      toolbar_height: ToolbarSimpleFastor.frameHeight,
    );
  }

  String getTitleText() {
    if (widget.mEdit != null) {
      pageTitle = "Edit $pageTitle";
    }
    return pageTitle;
  }

  Widget pageResponsiveWebOrMobile() {
    return ResponsiveFourmMobile.wrapHeight(contextPage!, getContent());
  }

  Widget getContent() {
    return ColumnTemplate.t(
        children: [
          name_en(),
          name_ar(),
          desc_en(),
          desc_ar(),
          price(),
          period(),
          product_numbers(),
          allow_chat(),
          save()
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start);
  }
}
