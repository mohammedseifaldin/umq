class RequestSubscribeUserByAdmin {

  /**
   required
   */
  String? userId;
  String? packageId;

  /**
   just save history in databsae of user information and package information
   */
  String? userName;
  String? userPhone;
  String? userImage;
  String? packageName;
  String? packagePeriod;
  String? packageAllowedProductNumers;
  String? packageAllowedChat;
  String? price;
  int byAdmin = 1; //number "1" means yes by admin

  RequestSubscribeUserByAdmin();


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
    data['by_admin'] = this.byAdmin;
    return data;
  }
}
