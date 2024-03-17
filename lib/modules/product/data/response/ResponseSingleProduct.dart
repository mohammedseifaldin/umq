import 'package:umq/modules/product/data/model/MProduct.dart';

class ResponseSingleProduct {
  String? status;
  int? code;
  MProduct? data;

  ResponseSingleProduct({this.status, this.code, this.data});

  ResponseSingleProduct fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new MProduct().fromJson(json['data']) : null;
    return this;
  }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['code'] = this.code;
  //   if (this.data != null) {
  //     data['data'] = this.data!.toJson();
  //   }
  //   return data;
  // }
}
