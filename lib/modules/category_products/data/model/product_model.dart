import 'package:umq/tools/network/BackendConstant.dart';

class ProductModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: "${BackendConstant.uplaods}/${json['image']}",
      price: json['price'] as int, 
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
