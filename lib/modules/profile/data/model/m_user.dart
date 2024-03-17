import 'package:umq/modules/place/data/model/MCity.dart';

class MUser {
  final int id;
  final String? name;
  final String? email;
  final String? emailVerifiedAt;
  final String? rememberToken;
  final String? fid;
  final int? cityId;
  final String? country;
  final String? mobile;
  final String? role;
  final int? block;
  final int? hidden;
  String? photo;
  final int? createdAt;
  final int? updatedAt;
  final MCity? city;

  MUser({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.rememberToken,
    required this.fid,
    this.cityId,
    required this.country,
    required this.mobile,
    required this.role,
    required this.block,
    required this.hidden,
    required this.photo,
    this.createdAt,
    this.updatedAt,
    this.city,
  });

  factory MUser.fromJson(Map<String, dynamic> json) {
    return MUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      rememberToken: json['remember_token'],
      fid: json['fid'],
      cityId: json["city_id"],
      country: json['country'],
      mobile: json['mobile'],
      role: json['role'],
      block: json['block'],
      hidden: json['hidden'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      city: json['city'] != null ? MCity().fromJson(json['city']) : null,
    );
  }

  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['email'] = this.email;
  //   data['email_verified_at'] = this.emailVerifiedAt;
  //   data['remember_token'] = this.rememberToken;
  //   data['fid'] = this.fid;
  //   data['country'] = this.country;
  //   data['mobile'] = this.mobile;
  //   data['role'] = this.role;
  //   data['block'] = this.block;
  //   data['hidden'] = this.hidden;
  //   data['photo'] = this.photo;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   return data;
  // }

  @override
  String toString() {
    return 'MUser{id: $id, name: $name, email: $email, emailVerifiedAt: $emailVerifiedAt, rememberToken: $rememberToken, fid: $fid, country: $country, mobile: $mobile, role: $role, block: $block, hidden: $hidden, photo: $photo, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  // void removeLocalImage() {
  //   if (photo == null) return;
  //   if (photo!.startsWith("http://192.")) {
  //     photo = null;
  //   }
  // }
}
