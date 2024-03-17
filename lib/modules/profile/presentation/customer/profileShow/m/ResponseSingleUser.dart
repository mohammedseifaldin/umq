import 'package:umq/modules/profile/data/model/m_user.dart';

class ResponseSingleUser {
  String? status;
  int? code;
  MUser? data;

  ResponseSingleUser({this.status, this.code, this.data});

  ResponseSingleUser.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? MUser.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    return data;
  }
}