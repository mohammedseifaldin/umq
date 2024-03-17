import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';

class ResponseArraySubscribePackage {
  String? status;
  int? code;
  List<MSubscribePackage>? data;

  ResponseArraySubscribePackage({this.status, this.code, this.data});

  ResponseArraySubscribePackage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = <MSubscribePackage>[];
      json['data'].forEach((v) {
        data!.add(new MSubscribePackage.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
