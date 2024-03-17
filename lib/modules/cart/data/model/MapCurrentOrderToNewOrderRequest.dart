import 'package:flutter/cupertino.dart';
import 'package:umq/modules/cart/data/request/OrderRequest.dart';
import 'package:umq/modules/cart/shared/EOrderStatus.dart';
import 'package:umq/modules/cart/shared/OrderCurrentSingletone.dart';

class MapCurrentOrderToNewOrderRequest {

  /**
      {
      "user_id": "16",
      "payment_method": "cash",
      "payment_online_id": "0",
      "shipment_id": "1",
      "address_detail": "10 Street, Macka",
      "city_id": "1",
      "country": "SR",
      "status_order": "new",
      "product_detail": "@1=3"
      }
   */
  static Future<OrderRequest> generateFromCurrentOrder(BuildContext context) async {

    OrderRequest request = OrderRequest();

    request.userId =  OrderCurrentSingletone.instance().userId.toString();
    request.paymentMethod =  OrderCurrentSingletone.instance().paymentMethod;
    request.paymentOnlineId =  OrderCurrentSingletone.instance().onlinePayment_orderId;
    request.shipmentId =  null;
    request.addressDetail =  OrderCurrentSingletone.instance().address;
    request.cityId =  OrderCurrentSingletone.instance().city.id.toString();
    request.country =  OrderCurrentSingletone.instance().countryISO;
    request.statusOrder =  EOrderStatus.newOrder.name;

    //detail
    var cartList = OrderCurrentSingletone.instance().cartList;
    String toStringAllCarList =  cartList.toString();
    request.productDetail =  toStringAllCarList;
    return request;
  }


}