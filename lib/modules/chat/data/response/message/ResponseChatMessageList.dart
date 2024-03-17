import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';

class ResponseChatMessageList {
  String? status;
  int? code;
  DataChatMessageList? data;
  MChatUser? userTarget;
  MUser? userTargetSmall;
  int? first_time_chat;

  ResponseChatMessageList fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    first_time_chat = json['first_time_chat'];

    data = json['data'] != null
        ? DataChatMessageList.fromJson(json['data'])
        : null;

    userTarget = json['userTarget'] != null
        ? MChatUser().fromJson(json['userTarget'])
        : null;

    userTargetSmall = json['userTargetSmall'] != null
        ? MUser.fromJson(json['userTargetSmall'])
        : null;
    return this;
  }
}

class DataChatMessageList {
  int? currentPage;
  List<MChatMessage>? data;

  int? total; //totalBar records
  int? last_page; //totalBar pages

  DataChatMessageList.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MChatMessage>[];
      json['data'].forEach((v) {
        data!.add(MChatMessage().fromJson(v));
      });
    }

    total = json['total'];
    last_page = json['last_page'];
  }
}
