// {"id":7,"name":"مدربين الغوص","description":"خدمة تقدم على مستوي جميع انحاء المملكة العربية السعودية لتعليم الغوص والسباحة والحصول على شهادات","image":"1706918659.jpeg",
// "created_at":"2024-02-03T00:04:19.000000Z","updated_at":"2024-02-03T00:04:19.000000Z"}
import 'package:umq/tools/network/BackendConstant.dart';

class CategoryModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final DateTime createdAt;
  final DateTime updatedAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: "${BackendConstant.uplaods}/${json['image']}",
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
