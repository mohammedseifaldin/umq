import 'package:umq/modules/product_detail/data/model/provider_model.dart';
import 'package:umq/tools/network/BackendConstant.dart';

class ProductDetailsModel {
  final int id;
  final String name;
  final String description;
  final String image;
  final int providerId;
  final int serviceId;
  final int price;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProviderModel provider;

  ProductDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.image,
    required this.providerId,
    required this.serviceId,
    required this.price,
    required this.createdAt,
    required this.updatedAt,
    required this.provider,
  });

  factory ProductDetailsModel.fromJson(Map<String, dynamic> json) {
    
    return ProductDetailsModel(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      image: "${BackendConstant.baseUrlv3}/uploads/${json['image']}",
      price: json['price'] as int,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      providerId: json['provider_id'] as int,
      serviceId: json['service_id'] as int,
      provider: ProviderModel.fromJson(json['provider']),
    );
  }
}
