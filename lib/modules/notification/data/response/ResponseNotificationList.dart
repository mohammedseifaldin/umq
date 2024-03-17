import 'package:umq/modules/notification/data/model/MNotificationAdmin.dart';

class ResponseNotificationList {
  String? status;
  int? code;
  List<MNotificationAdmin>? data;

  ResponseNotificationList({this.status, this.code, this.data});

  ResponseNotificationList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if (json['data'] != null) {
      data = <MNotificationAdmin>[];
      json['data'].forEach((v) {
        data!.add(new MNotificationAdmin.fromJson(v));
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
