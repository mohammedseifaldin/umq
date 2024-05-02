import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';

class ResponseRegisterStudent {
  String? status;
  int? code;
  String? token;
  String? message;
  bool? userAlreadyFound;
  MUser? data;

  ResponseRegisterStudent.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    token = json['token'];
    message = json['message'];
    userAlreadyFound = json['user_already_found'];

    //optional value
    /**
     * in api regsiter case user phone already found
     */
    if (json.containsKey("data")) {
      Log.i("ResponseRegisterStudent - fromJson() - containsKey yes ");
      data = json['data'] != null ? MUser.fromJson(json['data']) : null;
    } else {
      Log.i("ResponseRegisterStudent - fromJson() - containsKey no ");
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['token'] = token;
    data['message'] = message;
    data['user_already_found'] = userAlreadyFound;
    // if (this.data != null) {
    //   data['data'] = this.data!.toJson();
    // }
    return data;
  }

  @override
  String toString() {
    return 'ResponseRegisterStudent{status: $status, code: $code, token: $token, message: $message, userAlreadyFound: $userAlreadyFound, data: $data}';
  }
}

class DataRegisterStudent {
  String? fid;
  String? country;
  String? mobile;
  String? role;
  int? id;

  DataRegisterStudent.fromJson(Map<String, dynamic> json) {
    fid = json['fid'];
    country = json['country'];
    mobile = json['mobile'];
    role = json['role'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fid'] = fid;
    data['country'] = country;
    data['mobile'] = mobile;
    data['role'] = role;
    data['id'] = id;
    return data;
  }
}
