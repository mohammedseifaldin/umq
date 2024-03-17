import 'package:umq/modules/home/data/model/MSlider.dart';

class ResponseSliderList {
  String? status;
  int? code;
  DataSlider? data;

  ResponseSliderList({this.status, this.code, this.data});

  ResponseSliderList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataSlider.fromJson(json['data']) : null;
  }

}

class DataSlider {
  int? currentPage;
  List<MSlider>? data;

  int? total;

  DataSlider(
      {this.currentPage,
        this.data,

        this.total});

  DataSlider.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <MSlider>[];
      json['data'].forEach((v) {
        data!.add(new MSlider.fromJson(v));
      });
    }

    total = json['total'];
  }

}
