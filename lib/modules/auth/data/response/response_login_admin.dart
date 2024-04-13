import '../../../profile/data/model/m_user.dart';

class ResponseLoginAdmin {
  String? status;
  int? code;
  int? newAccount;
  String? message;
  DataLogin? data;

  ResponseLoginAdmin fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? DataLogin().fromJson(json['data']) : null;
    newAccount = json['new_account'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }

    return data;
  }
}

class DataLogin {
  String? accessToken;
  String? tokenType;
  MUser? user;

  DataLogin fromJson(Map<String, dynamic> json) {
    accessToken = json['access_token'];
    tokenType = json['token_type'];
    user = json['user'] != null ? MUser.fromJson(json['user']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = accessToken;
    data['token_type'] = tokenType;
    // if (this.user != null) {
    // data['user'] = this.user!.toJson();
    // }
    return data;
  }
}
