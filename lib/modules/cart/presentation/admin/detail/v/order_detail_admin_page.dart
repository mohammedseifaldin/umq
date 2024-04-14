import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import '../../../../data/model/MOrder.dart';
import '../../../../data/model/MOrderVendor.dart';
import '../m/ExtenstionMapModelToWidget.dart';
import 'views/HeaderOrderDetail.dart';
import 'views/PaymentInfoOrderDetail.dart';
import 'views/ShippingInfoOrderDetail.dart';
import 'views/tableInvoice/TableInvoice.dart';
import '../../../../../../tools/resourceProject/ColorProject.dart';
import '../../../../../../tools/responsive/fourm/ResponsiveFormMobile.dart';
import '../../../../../../toolsUI/textfield/mobileCountry/MobileCountryView.dart';

class OrderDetailAdminPage extends StatefulWidget {
  final MOrder mShow;

  const OrderDetailAdminPage(this.mShow, {super.key});

  @override
  OrderDetailAdminState createState() => OrderDetailAdminState();
}

class OrderDetailAdminState extends ResumableState<OrderDetailAdminPage> {
  //-------------------------------------------------------------------- variable
  String pageTitle = "Order Detail";

  //name
  var nameEnTxt = "";
  final nameEnController = TextEditingController();

  //response and table
  late TableViewFastorState tbState;
  List<MOrderVendor> listProjectFiltered =
      []; //the list of project after fliter done
  List<Widget> listRow = []; //header + result

  //mobile
  MobileCountryViewState? mobileState;

  @override
  void dispose() {
    nameEnController.dispose();
    super.dispose();
  }

  //-------------------------------------------------------------------- build

  ProgressCircleState? prg;

  @override
  Widget build(BuildContext context) {
    mapModelToWidget();

    return getPageTemplate();
  }

  Widget getPageTemplate() {
    return PageTemplate.t(
      this,
      title: pageTitle,
      content: responsiveContent(),
      // assetBackgroundOpacity: 0.3,
      // assetBackground: DrawableProject.exampleAdmin(  "01"),
      toolbar:
          ToolbarSimpleFastor(context, pageTitle, iconColorBack: Colors.black),
      toolbar_height: ToolbarSimpleFastor.frameHeight,
      onChangeProgressState: (value) => prg = value,
    );
  }

  Widget responsiveContent() {
    return ResponsiveFourmMobile.wrapHeight(context, getContent());
  }

  Widget getContent() {
    return ColumnFastor(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //header
          orderTitle(),
          orderId(),
          orderDate(),

          //table
          titleProduct(),
          getTableInvoice(),

          //footer
          orderDetiailShippingInformation(),
          orderDetailPaymentInformation(),

          //margin
          EmptyView.empty(0, DSDimen.space_level_1)
        ]);
  }

  //---------------------------------------------------------------------- tools ui generice

  Widget separator() {
    return Container(
      width: DeviceTools.getWidth(context),
      height: 2,
      color: HexColor(ColorProject.blueTransparent_fish_front),
      margin: EdgeInsets.symmetric(vertical: DSDimen.space_level_2),
    );
  }
}
