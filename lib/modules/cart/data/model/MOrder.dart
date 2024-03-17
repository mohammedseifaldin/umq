import 'package:umq/modules/profile/data/model/m_user.dart';

import '../../../place/data/model/MCity.dart';
import 'MOrderVendor.dart';

class MOrder {
  int? userId;
  String? paymentMethod;
  String? paymentOnlineId;
  int? shipmentId;
  String? addressDetail;
  int? cityId;
  String? country;
  String? statusOrder;
  String? productDetail;
  String? productPrice;
  String? vatPrice;
  String? shipmentPrice;
  String? net;
  int? id;
  // bool? fcmStatus;
  // String? fcmMessageId;
  int? created;
  int? updated;
  MCity? city;
  MUser? user;

  List<MOrderVendor>? arrayOrderVendor;

  MOrder fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    paymentMethod = json['payment_method'];
    paymentOnlineId = json['payment_online_id'];
    shipmentId = json['shipment_id'];
    addressDetail = json['address_detail'];
    cityId = json['city_id'];
    country = json['country'];
    statusOrder = json['status_order'];
    productDetail = json['product_detail'];
    productPrice = json['product_price'];
    vatPrice = json['vat_price'];
    shipmentPrice = json['shipment_price'];
    net = json['net'];
    id = json['id'];
    // fcmStatus = json['fcm_status'];
    // fcmMessageId = json['fcm_message_id'];
    created = json['created'];
    updated = json['updated'];
    city = json['city'] != null ? MCity().fromJson(json['city']) : null;
    user = json['user'] != null ? MUser.fromJson(json['user']) : null;

    if (json['array_order_vendor'] != null) {
      arrayOrderVendor = <MOrderVendor>[];
      json['array_order_vendor'].forEach((v) {
        arrayOrderVendor!.add(MOrderVendor().fromJson(v));
      });
    }

    return this;
  }
}
