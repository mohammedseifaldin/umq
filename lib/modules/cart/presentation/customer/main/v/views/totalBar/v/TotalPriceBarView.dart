import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/MainCartController.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/totalBar/CartTotalBarController.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/MainCartPage.dart';
import 'package:umq/tools/resourceProject/ColorProject.dart';
import 'package:umq/tools/values/ToolsPrice.dart';

TotalPriceBarState? totalPriceState;

class TotalPriceBarView extends StatefulWidget {
  MainCartState parentState;

  TotalPriceBarView(this.parentState);

  @override
  TotalPriceBarState createState() {
    totalPriceState = TotalPriceBarState();
    return totalPriceState!;
  }
}

class TotalPriceBarState extends State<TotalPriceBarView> {
  //------------------------------------------------------------------------- varaible

  var totalPrice = "0.0";

  //------------------------------------------------------------------------- public

  void updateTotalPrice(String newValue) {
    //check mounted
    if (mounted == false) return;

    setState(() {
      totalPrice = newValue;
    });
  }

  //------------------------------------------------------------------------- lifecycle

  @override
  void initState() {
    super.initState();
    setTotalFromResponseFirstTime();
  }

  //------------------------------------------------------------------------- build

  @override
  Widget build(BuildContext context) {
    return getTotalBar();
  }

  Widget getTotalBar() {
    //check progress
    if (widget.parentState.progress) {
      return EmptyView.zero();
    }

    //check empty
    if (widget.parentState.response == null ||
        widget.parentState.response!.data == null) {
      return emptyCart();
    }

    return _showBar();
  }

  Widget emptyCart() {
    return TextTemplate.t("Cart Empty",
        margin: EdgeInsets.all(DSDimen.text_level_parent),
        gravityLayoutAlign: Alignment.center,
        levelDS: LevelDS.l3);
  }

  Widget _showBar() {
    //card
    return Container(
      child: _getContent(),
      //decoration
      decoration: BoarderHelper.cardView(),
      padding: EdgeInsets.all(DSDimen.space_level_3),
      margin: EdgeInsets.only(
          left: DSDimen.space_level_2,
          right: DSDimen.space_level_2,
          top: DSDimen.space_level_2),
    );
  }

  Widget _getContent() {
    return ColumnTemplate.t(
        children: [_rowTotalPrice(), separtorLine(), bt_checkout()]);
  }

  //------------------------------------------------------------------- check out

  Widget separtorLine() {
    return Container(
      width: DeviceTools.getWidth(context),
      height: 1,
      color: HexColor(ColorProject.white_sun_1),
      margin: EdgeInsets.symmetric(
          horizontal: DSDimen.text_level_4 / 2, vertical: DSDimen.text_level_4),
    );
  }

  Widget bt_checkout() {
    var bt = ButtonTemplate.t("Checkout", () {
      widget.parentState.clickNext(totalPrice);
    }, levelDS: LevelDS.l3);

    //alignment
    return Container(
      child: bt, width: DeviceTools.getWidth(context),
      alignment: Alignment.center,
      //   margin: EdgeInsets.only(top: DSDimen.space_level_3),
    );
  }

  //------------------------------------------------------------------ row totalBar

  Widget _rowTotalPrice() {
    return Stack(
      children: [
        EmptyView.allDeviceWidth(context),
        title(),
        Positioned(
          child: _priceValueTv(),
          right: 0,
        )
      ],
    );
  }

  Widget title() {
    return TextTemplate.t("Total", levelDS: LevelDS.l3);
  }

  Widget _priceValueTv() {
    String removeFraction =
        ToolsPrice.removeFraction(totalPrice); // result.toString() + " SR";

    return TextTemplate.t(removeFraction, levelDS: LevelDS.l3);
  }
}
