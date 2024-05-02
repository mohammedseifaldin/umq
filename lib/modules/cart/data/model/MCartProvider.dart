import 'MCartSingleProduct.dart';
import '../../../teachers/data/model/MTeacher.dart';


class MCartProvider {

  int? index;
  int? providerId;
  MProvider? provider;
  List<MCartSingleProduct>? cartProviderProduct;

  MCartProvider({this.index, this.providerId, this.provider, this.cartProviderProduct});

  MCartProvider fromJson(Map<String, dynamic> json) {
    index = json['index'];
    providerId = json['provider_id'];
    provider = json['provider'] != null
        ? new MProvider().fromJson(json['provider'])
        : null;
    if (json['cart_product'] != null) {
      cartProviderProduct = <MCartSingleProduct>[];
      json['cart_product'].forEach((v) {
        cartProviderProduct!.add(new MCartSingleProduct.fromJson(v));
      });
    }
    return this;
  }
//
// Map<String, dynamic> toJson() {
//   final Map<String, dynamic> data = new Map<String, dynamic>();
//   data['index'] = this.index;
//   data['provider_id'] = this.providerId;
//   if (this.provider != null) {
//     data['provider'] = this.provider!.toJson();
//   }
//   if (this.cartProviderProduct != null) {
//     data['cart_product'] = this.cartProviderProduct!.map((v) => v.toJson()).toList();
//   }
//   return data;
// }
}