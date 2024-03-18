
import 'package:umq/modules/product/data/model/MCategory.dart';

class MProduct {
  /**
   */
  int? id;
  int? categoryId;
  String? nameAr;
  String? nameEn;
  String? description_ar;
  String? description_en;
  int? price;
  int? status;
  int? hidden;
  String? rent;
  int? providerId;
  String? image;
  int? createdAt;
  int? updatedAt;
  double? rate;
  int? favorite;
  int? cartCounter;
  int? userId;
  String? provider_mobile;
  String? provider_country;

  ProviderProduct? provider;
  MCategory? category;

  MProduct fromJson(Map<String, dynamic> json) {
    id = json['id'];
   //Log.i( "MProduct() - id: " + id.toString() );

    categoryId = json['category_id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    description_ar = json['description_ar'];
    description_en = json['description_en'];
   // Log.i( "MProduct() - fromJson: " + description_ar.toString() );
    price = json['price'];
    status = json['status'];
    hidden = json['hidden'];
    rent = json['rent'];
    providerId = json['provider_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    // rate = json['rate'];

    //fix double value sometimes return integer "0" without fraction
    var rate_str = json['rate'].toString();
    rate = double.parse(rate_str);

    favorite = json['favorite'];
    userId = json['user_id'];
    cartCounter = json['cart_counter'];
    provider = json['provider'] != null
        ? new ProviderProduct.fromJson(json['provider'])
        : null;
    category = json['category'] != null
        ? new MCategory.fromJson(json['category'])
        : null;

    //optional
    if (json['provider_mobile'] != null) {
      provider_mobile = json['provider_mobile'];
    }
    if (json['provider_country'] != null) {
      provider_country = json['provider_country'];
    }
  // Log.i( "MProduct() - provider_mobile: " + provider_mobile.toString() );
   //Log.i( "MProduct() - category: " + category.toString() );
    return this;
  }

  @override
  String toString() {
    return 'MProduct{id: $id, categoryId: $categoryId, nameAr: $nameAr, nameEn: $nameEn, description_ar: $description_ar, description_en: $description_en, price: $price, status: $status, hidden: $hidden, rent: $rent, providerId: $providerId, image: $image, createdAt: $createdAt, updatedAt: $updatedAt, rate: $rate, favorite: $favorite, cartCounter: $cartCounter, userId: $userId, provider_mobile: $provider_mobile, provider_country: $provider_country, provider: $provider, category: $category}';
  }
}

class ProviderProduct{
  int? id;
  String? whats;


  ProviderProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    whats = json['whats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['whats'] = this.whats;
    return data;
  }

  @override
  String toString() {
    return 'ProviderProduct{id: $id, whats: $whats}';
  }
}