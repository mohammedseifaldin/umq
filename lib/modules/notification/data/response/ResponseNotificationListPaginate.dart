import 'package:umq/modules/notification/data/model/MNotificationAdmin.dart';

class ResponseNotificationListPaginate {
  String? status;
  int? code;
  DataNotificationList? data;

  ResponseNotificationListPaginate({this.status, this.code, this.data});

  ResponseNotificationListPaginate.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataNotificationList.fromJson(json['data']) : null;
  }


}

class DataNotificationList {
  int? currentPage;
  List<MNotificationAdmin>? data;
  String? firstPageUrl;
  int? from;
  int? to;
  int? total;

  DataNotificationList.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MNotificationAdmin>[];
      json['data'].forEach((v) {
        data!.add(new MNotificationAdmin.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    to = json['to'];
    total = json['total'];
  }

}
