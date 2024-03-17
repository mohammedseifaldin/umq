import 'package:umq/modules/subscribe/data/model/MSubscribeUser.dart';

class ResponseSubscribeUsers {

  String? status;
  int? code;
  DataSubscribeUsers? data;

  ResponseSubscribeUsers({this.status, this.code, this.data});

  ResponseSubscribeUsers.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataSubscribeUsers.fromJson(json['data']) : null;
  }

}

class DataSubscribeUsers {
  int? currentPage;
  int? total;
  List<MSubscribeUser>? data;



  DataSubscribeUsers.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MSubscribeUser>[];
      json['data'].forEach((v) {
        data!.add(new MSubscribeUser.fromJson(v));
      });
    }
    total = json['total'];
  }

}
