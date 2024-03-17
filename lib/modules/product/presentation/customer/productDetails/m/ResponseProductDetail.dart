import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';

class ResponseProductDetail {
  String? status;
  int? code;
  MProduct? data;

  ResponseProductDetail({this.status, this.code, this.data});

  ResponseProductDetail.fromJson(Map<String, dynamic> json) {
    //Log.i( "ResponseProductDetail() - json: " + json.toString() );

    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new MProduct().fromJson(json['data']) : null;
  }

  @override
  String toString() {
    return 'ResponseProductDetail{status: $status, code: $code, data: $data}';
  }
}
