import 'package:umq/modules/profile/data/model/MOrganization.dart';

class ResponseOrgList {
  String? status;
  int? code;
  DataOrganization? data;


  ResponseOrgList fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataOrganization.fromJson(json['data']) : null;
    return this;
  }


}

class DataOrganization {

  List<MOrganization>? data;
  int? currentPage;
  int? total;


  DataOrganization.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <MOrganization>[];
      json['data'].forEach((v) {
        data!.add(new MOrganization.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    total = json['total'];
  }

}

