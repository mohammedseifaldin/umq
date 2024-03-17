import 'package:umq/modules/cart/data/model/MCartProvider.dart';

class ResponseCartProviderList {
  String? status;
  int? code;
  List<MCartProvider>? data;

  ResponseCartProviderList({this.status, this.code, this.data});

  ResponseCartProviderList fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = <MCartProvider>[];
      json['data'].forEach((v) {
        data!.add(new MCartProvider().fromJson(v));
      });
    }
    return this;
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['status'] = this.status;
  //   data['code'] = this.code;
  //   if (this.data != null) {
  //     data['data'] = this.data!.map((v) => v.toJson()).toList();
  //   }
  //   return data;
  // }
}
