import 'package:umq/modules/product/data/model/MCategory.dart';

/**
 category of product
 */
class ResponsePaginateCategory {
  String? status;
  int? code;
  CategoryData? data;

  ResponsePaginateCategory({this.status, this.code, this.data});

  ResponsePaginateCategory.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new CategoryData().fromJson(json['data']) : null;
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

class CategoryData {

  List<MCategory>? data;

  int? currentPage;
  int? total;



  CategoryData fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <MCategory>[];
      json['data'].forEach((v) {
        data!.add(new MCategory.fromJson(v));
      });
    }
    currentPage = json['current_page'];
    total = json['total'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['current_page'] = this.currentPage;
    data['total'] = this.total;
    return data;
  }
}


// class ResponseCategory {
//   bool status;
//   List<CategoryData> data;
//
//   ResponseCategory(
//       this.status,
//       this.data,
//       );
//
//   ResponseCategory.fromJson(Map<String, dynamic> json)
//       : status = json["status"]=='success',
//         data = json['data']['data'].map<CategoryData>((value) => CategoryData.fromJson(value)).toList();
//
//   Map<String, dynamic> toJson() => {
//         'success': status,
//       };
// }
// class CategoryData {
//   dynamic id;
//   dynamic name;
//
//   CategoryData(
//       this.id,
//       this.name,
//       );
//
//   CategoryData.fromJson(Map<String, dynamic> json)
//       : id = json["id"],
//         name = json["name_en"];
//
//
// }
