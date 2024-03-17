
class MSubscribeUser {

  int? id;
  int? userId;
  String? userName;
  String? userPhone;
  String? userImage;
  String? packageId;
  String? packageName;
  String? packagePeriod;
  String? packageAllowedProductNumers;
  String? packageAllowedChat;
  String? price;
  String? byAdmin;
  String? paymentMethod;
  String? paymentTransactionId;
  int? created;
  int? updated;


  MSubscribeUser.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    userName = json['user_name'];
    userPhone = json['user_phone'];
    userImage = json['user_image'];
    packageId = json['package_id'].toString();
    packageName = json['package_name'];
    packagePeriod = json['package_period'].toString();
    packageAllowedProductNumers = json['package_allowed_product_numers'].toString();
    packageAllowedChat = json['package_allowed_chat'].toString();
    price = json['price'].toString();
    byAdmin = json['by_admin'].toString();
    paymentMethod = json['payment_method'].toString();
    paymentTransactionId = json['payment_transaction_id'].toString();
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['user_name'] = this.userName;
    data['user_phone'] = this.userPhone;
    data['user_image'] = this.userImage;
    data['package_id'] = this.packageId;
    data['package_name'] = this.packageName;
    data['package_period'] = this.packagePeriod;
    data['package_allowed_product_numers'] = this.packageAllowedProductNumers;
    data['package_allowed_chat'] = this.packageAllowedChat;
    data['price'] = this.price;
    data['by_admin'] = this.byAdmin;
    data['payment_method'] = this.paymentMethod;
    data['payment_transaction_id'] = this.paymentTransactionId;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }
}
