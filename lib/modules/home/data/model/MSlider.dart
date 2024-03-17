
class MSlider {
  int? id;
  String? image;
  String? objectType;
  int? providerId;
  int? productId;
  int? createdAt;
  int? updatedAt;

  MSlider(
      {this.id,
        this.image,
        this.objectType,
        this.providerId,
        this.productId,
        this.createdAt,
        this.updatedAt});

  MSlider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    objectType = json['object_type'];
    providerId = json['provider_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['image'] = image;
    data['object_type'] = objectType;
    data['provider_id'] = providerId;
    data['product_id'] = productId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }

  @override
  String toString() {
    return 'MSlider{id: $id, image: $image}';
  }
}