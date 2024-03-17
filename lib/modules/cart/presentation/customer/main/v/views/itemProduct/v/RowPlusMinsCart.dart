import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:flutter/material.dart';
import 'package:umq/modules/cart/presentation/customer/main/c/itemProduct/ItemProductCartController.dart';
import 'package:umq/modules/cart/presentation/customer/main/v/views/itemProduct/v/ItemProductCartView.dart';

extension RowPlusMinsCart on ItemProductCartState {
  //-------------------------------------------------------- row Plus Mines

  Widget rowPlusMines() {
    return Stack(
      children: [
        EmptyView.empty(150, 50),

        //mines -
        Positioned(left: 0, top: 0, bottom: 0, child: bt_minesView()),

        // coutner
        Positioned(
            left: 30, top: 0, bottom: 0, child: chooseProgressOrCounter()),

        //plus +
        Positioned(
          child: bt_plusView(),
          left: 70,
          top: 0,
          bottom: 0,
        ),
      ],
    );
  }

  Widget bt_plusView() {
    var icon = Icon(
      Icons.add,
      size: 30,
      color: Colors.blue.shade900,
    );

    var mat = Material(
      child: icon,
      color: Colors.transparent,
    );

    return GestureDetector(
      onTap: () async {
        incrementClick(widget.mCart);
      },
      child: CircleAvatar(
        child: mat,
        radius: 15,
        backgroundColor: Colors.blue[300],
      ),
    );
  }

//----------------------------------------------------------------  mines -

  Widget bt_minesView() {
    var icon = Icon(
      Icons.remove,
      size: 30,
      color: Colors.white,
    );

    var mat = Material(
      child: icon,
      color: Colors.transparent,
    );

    return GestureDetector(
      onTap: () {
        decrementClick(widget.mCart);
      },
      child: CircleAvatar(
        child: mat,
        backgroundColor: Colors.red,
        radius: 15,
      ),
    );
  }

  //-------------------------------------------------------------- counter cart

  Widget chooseProgressOrCounter() {
    if (progressPlusMines) {
      return progressInsteadOfCounter();
    }

    return tv_counterCartView();
  }

  Widget tv_counterCartView() {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: Text(
        counterCurrent.toString(),
        style: TextStyle(color: Colors.black, decoration: TextDecoration.none),
      ),
    );
  }

  Widget progressInsteadOfCounter() {
    var progress = ProgressCircleFastor(size: 15);

    return CircleAvatar(
      backgroundColor: Colors.transparent,
      child: progress,
    );
  }
}
