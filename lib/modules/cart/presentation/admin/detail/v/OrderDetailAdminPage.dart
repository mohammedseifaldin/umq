import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:need_resume/need_resume.dart';
import 'package:umq/modules/cart/data/model/MOrder.dart';
import 'package:umq/modules/cart/data/model/MOrderVendor.dart';
import 'package:umq/modules/cart/presentation/admin/detail/m/ExtenstionMapModelToWidget.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/views/HeaderOrderDetail.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/views/PaymentInfoOrderDetail.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/views/ShippingInfoOrderDetail.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/views/tableInvoice/TableInvoice.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/responsive/fourm/ResponsiveFormMobile.dart';
import 'package:umq/toolsUI/textfield/mobileCountry/MobileCountryView.dart';
//import 'package:umq/toolsUI/toolbar/ToolbarSimpleFastor.dart';

class OrderDetailAdminPage extends StatefulWidget {
  MOrder mShow;

  OrderDetailAdminPage(this.mShow, {super.key}) {
    mShow = mShow;
  }

  @override
  OrderDetailAdminState createState() {
    return OrderDetailAdminState();
  }
}

class OrderDetailAdminState extends ResumableState<OrderDetailAdminPage> {
  //-------------------------------------------------------------------- variable
  String pageTitle = "Order Detail";

  //name
  var nameEn_txt = "";
  var nameEn_valid = AutovalidateMode.disabled;
  var nameEn_controller = TextEditingController();

  //response and table
  late TableViewFastorState tbState;
  List<MOrderVendor> listProjectFiltered =
      []; //the list of project after fliter done
  List<Widget> listRow = []; //header + result

  //mobile
  MobileCountryViewState? mobileState;

  //------------------------------------------------------------------- life cycle

  @override
  void onReady() {
    super.onReady();
    onResume();
  }

  //-------------------------------------------------------------------- build

  ProgressCircleState? prg;

  @override
  Widget build(BuildContext context) {
    mapModelToWidget();

    return getPageTemplate();
  }

  Widget getPageTemplate() {
    return PageTemplate.t(this,
        title: pageTitle,
        content: responsiveContent(),
        // assetBackgroundOpacity: 0.3,
        // assetBackground: DrawableProject.exampleAdmin(  "01"),
        toolbar: ToolbarSimpleFastor(context, pageTitle,
            iconColorBack: Colors.black),
        toolbar_height: ToolbarSimpleFastor.frameHeight,
        onChangeProgressState: (value) => prg = value);
  }

  Widget responsiveContent() {
    return ResponsiveFourmMobile.wrapHeight(context, getContent());
  }

  Widget getContent() {
    return ColumnTemplate.t(
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
        ],
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start);
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
