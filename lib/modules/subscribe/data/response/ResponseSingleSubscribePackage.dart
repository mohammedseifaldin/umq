import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';

class ResponseSingleSubscribePackage {

  String? status;
  int? code;
  MSubscribePackage? data;

  ResponseSingleSubscribePackage({this.status, this.code, this.data});

  ResponseSingleSubscribePackage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new MSubscribePackage.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
