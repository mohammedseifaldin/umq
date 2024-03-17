import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';
import 'package:umq/modules/chat/data/model/MChatUser.dart';


/** ------ case: no user list found
    {
    "status": "error",
    "code": 0,
    "data": "No record found"
    }
 */
class ResponseChatUserList {

  String? status;
  int? code;
  DataChatList? data;
  MChatUser? navigate_user;  //the user will navigate to him

  ResponseChatUserList({this.status, this.code, this.data});

  ResponseChatUserList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];

    navigate_user = json['navigate_user'] != null
        ? new MChatUser().fromJson(json['navigate_user'])
        : null;

     data = json['data'] != null ? new DataChatList().fromJson(json['data']) : null;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}


class DataChatList {

  List<MChatUser>? data = [];
  // String? firstPageUrl;
  // int? from;
  // int? to;
  int? currentPage;
  int? total;


  DataChatList fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    //Log.i( "DataChatList - currentPage: " + currentPage.toString() );

    if (json['data'] != null) {
      data = <MChatUser>[];
      json['data'].forEach((v) {
         data!.add(new MChatUser().fromJson(v));
      });
    }
    // firstPageUrl = json['first_page_url'];
    total = json['total'];
    return this;
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    // data['first_page_url'] = this.firstPageUrl;
    data['total'] = this.total;
    return data;
  }


}
