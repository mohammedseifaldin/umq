import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';

class ResponseListProvider {
  String? status;
  int? code;
  List<MProvider>? data;

  ResponseListProvider({this.status, this.code, this.data});

  ResponseListProvider.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];

    if (json['data'] != null) {
      data = <MProvider>[];
      json['data'].forEach((v) {
        data!.add(new MProvider().fromJson(v));
        // Log.i( "DataCity - fromJson - data: " + data.toString() );
      });
    }
  }

  @override
  String toString() {
    return 'ResponseListCity{status: $status, code: $code, data: $data}';
  }
}
//
// class DataProviders {
//
//   List<MProvider>? data;
//   int? currentPage;
//   int? total;
//
//   @override
//   String toString() {
//     return 'DataCity{data: $data, currentPage: $currentPage, totalBar: $total}';
//   }
//
//
//   DataProviders.fromJson(Map<String, dynamic> json) {
//
//     if (json['data'] != null) {
//       data = <MProvider>[];
//       json['data'].forEach((v) {
//         data!.add(new MProvider().fromJson(v));
//        // Log.i( "DataCity - fromJson - data: " + data.toString() );
//       });
//     }
//     if (json['current_page'] != null) {
//       currentPage = json['current_page'];
//     }
//     if (json['total'] != null) {
//       total = json['total'];
//     }
//   }
//
//
// }
