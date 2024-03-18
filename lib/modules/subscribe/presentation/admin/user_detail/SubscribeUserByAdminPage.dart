import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:provider/provider.dart';
import 'package:umq/modules/subscribe/data/request/RequestSubscribeUserByAdmin.dart';
import 'package:umq/modules/subscribe/presentation/admin/user_detail/widget/ContentUserDetail.dart';
import 'package:umq/modules/subscribe/provider/SubscribeChangeNotifier.dart';
import 'package:umq/modules/subscribe/provider/SubscribeUserByAdminPage.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';

class SubscribeUserByAdminPage extends StatefulWidget {
  SubscribeUserByAdminPage();
  @override
  SubscribeUserByAdminState createState() {
    return SubscribeUserByAdminState();
  }
}

class SubscribeUserByAdminState
    extends ResumableState<SubscribeUserByAdminPage> {
  //-------------------------------------------------------------------- variable
  String pageTitle = "Subscribe User";

  SubscribeChangeNotifier? provider;
  RequestSubscribeUserByAdmin request = RequestSubscribeUserByAdmin();

  //------------------------------------------------------------------- life cycle

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      provider?.downloadSubscribePackageAllData(context);
    });
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
    this.contextPage = context;

    return PageFastor(
      this,
      title: pageTitle,
      statusBarColorCustom: HexColor(ColorProject.black_4),
      content: pageResponsiveWebOrMobile(),
      toolbar: ToolbarSimpleFastor(contextPage!, pageTitle,
          iconColorBack: Colors.black),
      toolbar_height: ToolbarSimpleFastor.frameHeight,
    );
  }

  Widget pageResponsiveWebOrMobile() {
    return ResponsiveFourmMobile.wrapHeight(
        contextPage!, blocConsumerSubscribe());
  }

  Widget blocConsumerSubscribe() {
    return Consumer<SubscribeChangeNotifier>(
        builder: (context, notifier, child) {
      provider = notifier; // SubscribeChangeNotifier.getListenFalse(context);
      return getContent();
    });
  }

  Widget getContent() {
    return ColumnTemplate.t(
        children: [
          SizedBox(height: DSDimen.space_level_2),
          buttonPickerUserWidget(),
          SizedBox(height: DSDimen.space_level_2),
          selectPackage(),
          SizedBox(height: DSDimen.space_level_2),
          save(),
          SizedBox(height: DSDimen.space_level_2),
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start);
  }
}
