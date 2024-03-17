/**
 * this class just carry data of order send in request in api
 */
class OrderRequest {

  String? userId;
  String? paymentMethod;
  String? paymentOnlineId;
  String? shipmentId  ;
  String? addressDetail;
  String? cityId;
  String? country;
  String? statusOrder;
  String? productDetail; //convert cart to json

}

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