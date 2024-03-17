import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/receipt/v/CartReceiptPage.dart';
import 'package:umq/modules/cart/shared/CartUtils.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';
import 'package:umq/tools/constant/EPaymentMethod.dart';
import 'package:umq/tools/resourceProject/FontProject.dart';
import 'package:umq/tools/values/ToolsPrice.dart';

extension PaymentInfoReceipt on CartReceiptState {
  Widget orderDetailPaymentInformation() {
    return ColumnTemplate.t(
        decoration: BoarderHelper.cardView(),
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

          priceProducts(),
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

    double price = OrderCurrentUtils.totalInvoice();
    String name = ToolsPrice.prefixDouble(price);

    //check not selected
    if (price == 0) {
      name = "Cart is empty";
    }

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        fontFamily: FontProject.beach,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget vatFees() {
    var title = TextTemplate.t("VAT . 5%", levelDS: LevelDS.l2);

    double price = OrderCurrentUtils.vat();
    String name = ToolsPrice.prefixDouble(price);

    //check not selected
    if (price == 0) {
      name = "Cart is empty";
    }

    var nameTv = TextTemplate.t(name,
        levelDS: LevelDS.l3,
        fontFamily: FontProject.beach,
        margin: EdgeInsets.only(top: DSDimen.space_level_3));

    return ColumnTemplate.t(children: [title, nameTv]);
  }

  Widget priceProducts() {
    var title = TextTemplate.t("Total price Products", levelDS: LevelDS.l2);

    int price = OrderCurrentUtils.priceProductsAtCart();
    double price_double = double.parse(price.toString());
    String name = ToolsPrice.removeFraction(price_double.toString());

    //check not selected
    if (price == 0) {
      name = "Cart is empty";
    }

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
    var current = OrderCurrentSingletone.instance().paymentMethod;
    bool isOnlineSuccess =
        OrderCurrentSingletone.instance().onlinePayment_status;

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
      String transactionId =
          OrderCurrentSingletone.instance().onlinePayment_orderId;
      return "Online Payment Order : " + transactionId;
    }

    //return "لم تختار وسيلة دفع";
    return "";
  }
}
