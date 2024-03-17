import 'package:umq/modules/subscribe/data/model/MSubscribeUser.dart';

class ResponseSubscribeSingleUser {
  String? status;
  int? code;
  String? message;
  String? resFCMCustomer;
  String? resFCMAdmin;
  MSubscribeUser? data;

  ResponseSubscribeSingleUser(
      {this.status,
        this.code,
        this.resFCMCustomer,
        this.resFCMAdmin,
        this.data});

  ResponseSubscribeSingleUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    if( json.containsKey( "message") ) {
      message = json["message"];
    }

    resFCMCustomer = json['resFCM_customer'];
    resFCMAdmin = json['resFCM_admin'];
    data = json['data'] != null ? new MSubscribeUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['resFCM_customer'] = this.resFCMCustomer;
    data['resFCM_admin'] = this.resFCMAdmin;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
