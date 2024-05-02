import 'package:umq/modules/cart/data/model/MCartSingleProduct.dart';

class ResponseCartProductList {
  String? status;
  int? code;
  String? totalPrice;
  List<MCartSingleProduct>? data;

  ResponseCartProductList fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    totalPrice = json['totalPrice'];
    if (json['data'] != null) {
      data = <MCartSingleProduct>[];
      json['data'].forEach((v) {
        data!.add(new MCartSingleProduct.fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['totalPrice'] = this.totalPrice;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
