
import 'package:umq/modules/chat/data/model/MChatMessage.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';

class ResponseChatLastUpdate {


  // bool? tokenExpire;
  String? status;
  int? code;
  DataChatLastUpdate? data;


  ResponseChatLastUpdate fromJson(Map<String, dynamic> json) {
  //  tokenExpire = json['token_expire'];
    status = json['status'];
    code = json['code'];

    // if( json.containsKey( "data") ){
      data = json['data'] != null ? new DataChatLastUpdate.fromJson(json['data']) : null;
    // }

    return this;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['token_expire'] = this.tokenExpire;
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }


}

class DataChatLastUpdate {

  // String? start;
  // String? offset;
  String? indexLoop;
  int? next_socket_search_for_greater_than_id;
  List<MChatUser>? userUpdate;
  List<MChatMessage>? messageUpdate;


  DataChatLastUpdate.fromJson(Map<String, dynamic> json) {
    // start = json['start'];
    // offset = json['offset'];
    indexLoop = json["indexLoop"];
    next_socket_search_for_greater_than_id = json["next_socket_search_for_greater_than_id"];

    //user
    if (json['user_update'] != null) {
      userUpdate = <MChatUser>[];
      json['user_update'].forEach((v) {
        userUpdate!.add(new MChatUser().fromJson(v));
      });
    }

    //message
    if (json['message_update'] != null) {
      messageUpdate = <MChatMessage>[];
      json['message_update'].forEach((v) {
        messageUpdate!.add(new MChatMessage().fromJson(v));
      });
    }
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // data['start'] = this.start;
    // data['offset'] = this.offset;
    if (this.userUpdate != null) {
      data['user_update'] = this.userUpdate!.map((v) => v.toJson()).toList();
    }
    if (this.messageUpdate != null) {
      data['message_update'] =
          this.messageUpdate!.map((v) => v.toJson()).toList();
    }
    return data;
  }


}
