// class MChatUserInfo {
//   int? id;
//   String? name;
//   String? email;
//   String? emailVerifiedAt;
//   String? rememberToken;
//   String? fid;
//   int? cityId;
//   String? country;
//   String? mobile;
//   String? role;
//   int? block;
//   int? hidden;
//   String? photo;
//   String? createdAt;
//   String? updatedAt;
//
//
//   MChatUserInfo  fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     name = json['name'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     rememberToken = json['remember_token'];
//     fid = json['fid'];
//     cityId = json['city_id'];
//     country = json['country'];
//     mobile = json['mobile'];
//     role = json['role'];
//     block = json['block'];
//     hidden = json['hidden'];
//     photo = json['photo'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//     return this;
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['id'] = this.id;
//     data['name'] = this.name;
//     data['email'] = this.email;
//     data['email_verified_at'] = this.emailVerifiedAt;
//     data['remember_token'] = this.rememberToken;
//     data['fid'] = this.fid;
//     data['city_id'] = this.cityId;
//     data['country'] = this.country;
//     data['mobile'] = this.mobile;
//     data['role'] = this.role;
//     data['block'] = this.block;
//     data['hidden'] = this.hidden;
//     data['photo'] = this.photo;
//     data['created_at'] = this.createdAt;
//     data['updated_at'] = this.updatedAt;
//     return data;
//   }
//
// }