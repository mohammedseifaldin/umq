import 'package:umq/modules/notification/data/model/MNotificationAdmin.dart';

class ResponseNotificationAdminSingle {
  String? status;
  int? code;
  String? resFCM;
  bool? fcmStatus;
  MNotificationAdmin? data;

  ResponseNotificationAdminSingle(
      {this.status, this.code, this.resFCM, this.fcmStatus, this.data});

  ResponseNotificationAdminSingle.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    resFCM = json['resFCM'];
    fcmStatus = json['fcm_status'];
    data = json['data'] != null ? new MNotificationAdmin.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['resFCM'] = this.resFCM;
    data['fcm_status'] = this.fcmStatus;
    if (this.data != null) {
      data['data'] =  MNotificationAdmin().toJson();
    }
    return data;
  }
}
