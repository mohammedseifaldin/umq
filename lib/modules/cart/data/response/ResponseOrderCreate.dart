import 'package:umq/modules/cart/data/model/MOrder.dart';

class ResponseOrderSingle {
  String? status;
  int? code;
  int? clearCart;
  MOrder? data;

  ResponseOrderSingle({this.status, this.code, this.clearCart, this.data});

  ResponseOrderSingle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    clearCart = json['clearCart'];
    data = json['data'] != null ? new MOrder().fromJson(json['data']) : null;
  }


}
