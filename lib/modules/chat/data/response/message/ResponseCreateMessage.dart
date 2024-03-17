import 'package:umq/modules/chat/data/model/MChatMessage.dart';

class ResponseCreateMessage {
  String? status;
  int? code;

  MChatMessage? data;


  ResponseCreateMessage fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];

    data = json['data'] != null ? new MChatMessage().fromJson(json['data']) : null;
    return this;
  }


}

