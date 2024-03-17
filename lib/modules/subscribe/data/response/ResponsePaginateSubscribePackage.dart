import 'package:umq/modules/subscribe/data/model/MSubscribePackage.dart';

class ResponsePaginateSubscribePackage {

  String? status;
  int? code;
  SubscribePackageLaravelPaginate? data;

  ResponsePaginateSubscribePackage({this.status, this.code, this.data});

  @override
  String toString() {
    return 'ResponsePaginateSubscribePackage{status: $status, code: $code, data: $data}';
  }

  ResponsePaginateSubscribePackage.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new SubscribePackageLaravelPaginate.fromJson(json['data']) : null;
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

class SubscribePackageLaravelPaginate {

  int? currentPage;
  int? total;
  List<MSubscribePackage>? data;


  @override
  String toString() {
    return 'SubscribePackageLaravelPaginate{total: $total, currentPage: $currentPage, data: $data}';
  }

  SubscribePackageLaravelPaginate.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MSubscribePackage>[];
      json['data'].forEach((v) {
        data!.add(new MSubscribePackage.fromJson(v));
      });
    }
    total = json['total'];
  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = this.total;
    return data;
  }


}
