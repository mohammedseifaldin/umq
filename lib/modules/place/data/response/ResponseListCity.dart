import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/place/data/model/MCity.dart';

class ResponseCityList {
  String? status;
  int? code;
  DataCity? data;

  ResponseCityList({this.status, this.code, this.data});

  ResponseCityList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataCity.fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return 'ResponseListCity{status: $status, code: $code, data: $data}';
  }
}

class DataCity {

  List<MCity>? data;
  int? currentPage;
  int? total;

  @override
  String toString() {
    return 'DataCity{data: $data, currentPage: $currentPage, totalBar: $total}';
  }


  DataCity.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <MCity>[];
      json['data'].forEach((v) {
        data!.add(new MCity().fromJson(v));
       // Log.i( "DataCity - fromJson - data: " + data.toString() );
      });
    }
    currentPage = json['current_page'];
    total = json['total'];
  }


}
