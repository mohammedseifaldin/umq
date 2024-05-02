import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';

class MOrderVendor {
  int? id;
  int? orderProductId;
  int? providerId;
  int? userId;
  int? productId;
  String? productPrice;
  int? productQty;
  String? providerStatus;
  int? created;
  int? updated;
  MProduct? product;
  MProvider? mProvider;

  MOrderVendor fromJson(Map<String, dynamic> json) {
    id = json['id'];
    // Log.i( "MOrderVendor - id: " + id.toString() );

    orderProductId = json['order_product_id'];
    //  Log.i( "MOrderVendor - orderProductId: " + orderProductId.toString() );

    providerId = json['provider_id'];
    // Log.i( "MOrderVendor - providerId: " + providerId.toString() );

    userId = json['user_id'];
    // Log.i( "MOrderVendor - userId: " + userId.toString() );

    productId = json['product_id'];
    //Log.i( "MOrderVendor - productId: " + productId.toString() );

    productPrice = json['product_price'];
    //Log.i( "MOrderVendor - productPrice: " + productPrice.toString() );

    productQty = json['product_qty'];
    // Log.i( "MOrderVendor - productQty: " + productQty.toString() );

    providerStatus = json['provider_status'];
    //Log.i( "MOrderVendor - providerStatus: " + providerStatus.toString() );

    created = json['created'];
    updated = json['updated'];
    //Log.i( "MOrderVendor - updated: " + updated.toString() );

    product = json['product'] != null
        ? new MProduct().fromJson(json['product'])
        : null;
    mProvider = json['provider'] != null
        ? new MProvider().fromJson(json['provider'])
        : null;

    return this;
  }
}
