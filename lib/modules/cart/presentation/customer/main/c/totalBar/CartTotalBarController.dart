import 'package:umq/modules/cart/presentation/customer/main/v/views/totalBar/v/TotalPriceBarView.dart';

extension CartTotalBarController on TotalPriceBarState {

  void setTotalFromResponseFirstTime () {

    var result = "0.0";

    if( widget.parentState.response != null &&
        widget.parentState.response!.totalPrice != null ) {
      result = widget.parentState.response!.totalPrice!;
    }

    totalPrice = result;
  }



}