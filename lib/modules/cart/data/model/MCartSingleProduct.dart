import '../../../product/data/model/MProduct.dart';

class MCartSingleProduct {
  int? id;
  int? userId;
  int? productId;
  int? counter;
  int? updatedAt;
  MProduct? product;
  // Users? users;

  MCartSingleProduct({
    this.id,
    this.userId,
    this.productId,
    this.counter,
    this.updatedAt,
    this.product,
    //  this.users
  });

  MCartSingleProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    counter = json['counter'];
    updatedAt = json['updated_at'];
    product = json['product'] != null
        ? new MProduct().fromJson(json['product'])
        : null;
    // users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }
//
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['counter'] = this.counter;
    data['updated_at'] = this.updatedAt;
    if (this.product != null) {
      data['product'] = this.product!.toString();
    }
    // if (this.users != null) {
    //   data['users'] = this.users!.toJson();
    // }
    return data;
  }

  @override
  String toString() {
    return 'MCart{id: $id, userId: $userId, productId: $productId, counter: $counter, updatedAt: $updatedAt, product: $product}';
  }
}
