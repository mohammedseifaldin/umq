import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/admin/detail/v/order_detail_admin_page.dart';
import 'package:umq/tools/constant/EPaymentMethod.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/tools/values/ToolsPrice.dart';

extension PaymentInfoOrderDetail on OrderDetailAdminState {
  Widget orderDetailPaymentInformation() {
    return ColumnTemplate.t(
        decoration: BoarderHelper.cardView(
          colorLine: DSColor.table_row_title,
        ),
        padding: EdgeInsets.all(DSDimen.space_level_2),
        margin: EdgeInsets.only(
            top: DSDimen.space_level_2,
            left: DSDimen.space_level_2,
            right: DSDimen.space_level_2),
        children: [
          tvTitle(),
          EmptyView.empty(0, DSDimen.space_level_2), //margin

          paymentMethod(),
          separator(),

          totalPriceProducts(),
          separator(),

          vatFees(),
          separator(),

          total(),
          separator(),

          noticeShipmentFees()
        ]);
  }

  //----------------------------------------------------------------- shipment fees

  Widget noticeShipmentFees() {
    var title = TextTemplate.t("Shipping fees", levelDS: LevelDS.l2);

    var nameTv = TextTemplate.t(getMessageShippmentFess(),
        levelDS: LevelDS.l3,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  String getMessageShippmentFess() {
    // String ar =  "تختلف مصاريف الشحن حسب الوزن والمسافة." + "\n";
    String ar = "* مصاريف الشحن تحسب عن طريق شركة الشحن أرامكس ." + "\n";
    ar += "* هذه الفاتورة غير شاملة مصاريف الشحن .";

    if (LanguageTools.isArabic(context)) {
      return ar;
    }

    String en = "* Shipment fees calculated by Aramex ." + "\n";
    en += "* This invoice not included the Shipping fees .";
    return en;
  }

  //----------------------------------------------------------------------- price

  Widget total() {
    var title = TextTemplate.t("Total", levelDS: LevelDS.l2);

    var price = widget.mShow.net!;
    String name = ToolsPrice.prefixString(price);

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        fontFamily: FontProject.beach,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget vatFees() {
    var title = TextTemplate.t("VAT . 5%", levelDS: LevelDS.l2);

    String name = widget.mShow.vatPrice!;

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        fontFamily: FontProject.beach,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget totalPriceProducts() {
    var title = TextTemplate.t("Total price Products", levelDS: LevelDS.l2);

    // int price = int.parse( widget.mShow.productPrice! ) ;
    // double price_double = double.parse( price.toString() )  ;
    String name = ToolsPrice.removeFraction(widget.mShow.productPrice);

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        fontFamily: FontProject.beach,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget tvTitle() {
    return TextTemplate.t("Payment information", levelDS: LevelDS.l1);
  }

  //------------------------------------------------------------------------ payment method

  Widget paymentMethod() {
    var title = TextTemplate.t("Payment Method", levelDS: LevelDS.l2);

    String name = getNameOfPaymentMethod();

    //check not selected
    if (ToolsValidation.isEmpty(name)) {
      name = "Not Selected";
    }

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  String getNameOfPaymentMethod() {
    //get info
    var current = widget.mShow.paymentMethod;
    bool isOnline = widget.mShow.paymentMethod == EPaymentMethod.online;
    bool isHaveOnlineTransactionId =
        ToolsValidation.isValid(widget.mShow.paymentOnlineId);
    bool isOnlineSuccess = isHaveOnlineTransactionId && isOnline;

    //check empty
    if (ToolsValidation.isEmpty(current)) return "";

    //case: payment cash
    if (current == EPaymentMethod.cash.name) {
      return "Cash on delivery";
    }

    //case : payment online - status not completed
    if (isOnlineSuccess == false) {
      return "Online Payment not completed";
    }

    //case : payment online - status not completed
    if (isOnlineSuccess) {
      String transactionId = widget.mShow.paymentOnlineId ?? "";
      return "Online Payment Order : " + transactionId;
    }

    //return "لم تختار وسيلة دفع";
    return "";
  }
}
