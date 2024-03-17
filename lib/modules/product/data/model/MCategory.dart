
class MCategory {
  int? id;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  int? hidden;
  int? status;
  String? image;
  String? createdAt;
  String? updatedAt;


  MCategory(this.nameAr, this.nameEn);

  MCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    hidden = json['hidden'];
    status = json['status'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['hidden'] = this.hidden;
    data['status'] = this.status;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'MCategory{id: $id, nameEn: $nameEn, nameAr: $nameAr, descriptionEn: $descriptionEn, descriptionAr: $descriptionAr, hidden: $hidden, status: $status, image: $image, createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}

