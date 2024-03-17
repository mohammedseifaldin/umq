import 'package:umq/tools/network/BackendConstant.dart';

class ProviderModel {
  final int id;
  final String fid;
  final int cityId;
  final dynamic country;
  final String name;
  final String email;
  final String mobile;
  final String role;
  final String? rememberToken;
  final int block;
  final int hidden;
  final String photo;
  final DateTime? emailVerifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  ProviderModel({
    required this.id,
    required this.name,
    required this.fid,
    required this.cityId,
    this.country,
    required this.email,
    required this.mobile,
    required this.role,
    required this.block,
    required this.hidden,
    required this.photo,
    this.emailVerifiedAt,
    this.rememberToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    print(json);
    return ProviderModel(
      id: json['id'],
      name: json['name'] as String,
      email: json['email'] as String,
      mobile: json['mobile'] as String,
      fid: json['fid'],
      rememberToken: json['remember_token'] as String?,
      photo: "${BackendConstant.baseUrlv3}/uploads/${json['photo']}",
      block: json['block'],
      hidden: json['hidden'],
      role: json['role'] as String,
      createdAt: DateTime.fromMillisecondsSinceEpoch(json['created_at']),
      updatedAt: DateTime.fromMillisecondsSinceEpoch(json['updated_at']),
      cityId: json['city_id'] as int,
      country: json['country'],
      emailVerifiedAt: DateTime.tryParse(json['email_verified_at']??""),
    );
  }
}
