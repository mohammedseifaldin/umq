import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/tools/data/general/LaravelPaginateObjects.dart';
import 'package:umq/modules/profile/data/model/m_user.dart';

class ResponseUserList {
  String? status;
  int? code;
  LaravelUserList? dataLaravel;

  ResponseUserList();

  ResponseUserList fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    dataLaravel =
        json['data'] != null ? LaravelUserList.fromJson(json['data']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    if (this.dataLaravel != null) {
      data['data'] = this.dataLaravel!.toJson();
    }
    return data;
  }
}

class LaravelUserList {
  int? currentPage;
  int? total;
  List<MUser>? dataUsers;
  // String? firstPageUrl;
  // int? from;
  // int? lastPage;
  // String? lastPageUrl;
  // List<Links>? links;
  // String? nextPageUrl;
  // String? path;
  // String? perPage;
  // String? prevPageUrl;
  // int? to;

  LaravelUserList.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      dataUsers = <MUser>[];
      json['data'].forEach((v) {
        var m = MUser.fromJson(v);
        dataUsers!.add(m);
        // Log.i( "response parse - mUser: " + m.toString() );
      });
    }
    currentPage = json['current_page'];
    total = json['total'];
    // Log.i( "response parse - totalBar: " + totalBar.toString() );

    // firstPageUrl = json['first_page_url'];
    // from = json['from'];
    // lastPage = json['last_page'];
    // lastPageUrl = json['last_page_url'];
    // if (json['links'] != null) {
    //   links = <Links>[];
    //   json['links'].forEach((v) {
    //     links!.add(new Links.fromJson(v));
    //   });
    // }
    // nextPageUrl = json['next_page_url'];
    // path = json['path'];
    // perPage = json['per_page'];
    // prevPageUrl = json['prev_page_url'];
    // to = json['to'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    // if (this.dataUsers != null) {
    //   data['data'] = this.dataUsers!.map((v) => v.toJson()).toList();
    // }
    data['current_page'] = this.currentPage;
    data['total'] = this.total;

    // data['first_page_url'] = this.firstPageUrl;
    // data['from'] = this.from;
    // data['last_page'] = this.lastPage;
    // data['last_page_url'] = this.lastPageUrl;
    // if (this.links != null) {
    //   data['links'] = this.links!.map((v) => v.toJson()).toList();
    // }
    // data['next_page_url'] = this.nextPageUrl;
    // data['path'] = this.path;
    // data['per_page'] = this.perPage;
    // data['prev_page_url'] = this.prevPageUrl;
    // data['to'] = this.to;

    return data;
  }
}
