import 'package:umq/modules/cart/data/model/MOrder.dart';

class ResponseOrderList {
  String? status;
  int? code;
  DataOrderList? data;

  ResponseOrderList({this.status, this.code, this.data});

  ResponseOrderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataOrderList.fromJson(json['data']) : null;
  }

}

class DataOrderList {
  int? currentPage;
  List<MOrder>? data;
  int? from;
  int? to;
  int? total;

  DataOrderList(
      {this.currentPage,
        this.data,

        this.from,

        this.to,
        this.total});

  DataOrderList.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MOrder>[];
      json['data'].forEach((v) {
        data!.add(new MOrder().fromJson(v));
      });
    }

    from = json['from'];

    to = json['to'];
    total = json['total'];
  }


}
