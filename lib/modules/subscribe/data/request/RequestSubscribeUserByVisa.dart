class RequestSubscribeUserByVisa {
  String? userId;
  String? userName;
  String? userPhone;
  String? userImage;
  String? packageId;
  String? packageName;
  String? packagePeriod;
  String? packageAllowedProductNumers;
  String? packageAllowedChat;

  String? price;
  String? paymentMethod;
  String? paymentTransactionId;

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data["user_image"] = this.userImage;
    data['package_id'] = this.packageId;
    data['package_name'] = this.packageName;
    data['package_period'] = this.packagePeriod;
    data['package_allowed_product_numers'] = this.packageAllowedProductNumers;
    data['package_allowed_chat'] = this.packageAllowedChat;

    data['price'] = this.price;
    data['payment_method'] = this.paymentMethod;
    data['payment_transaction_id'] = this.paymentTransactionId;
    return data;
  }
}
