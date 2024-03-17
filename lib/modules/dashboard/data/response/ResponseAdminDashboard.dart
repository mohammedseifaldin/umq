class ResponseAdminDashboard {
  String? status;
  int? code;
  String? message;
  int? student;
  int? provider;
  int? product;
  int? productCategory;
  int? galleryImage;
  int? galleryVideo;
  int? chatMessage;
  int? order;
  int? subscribers;
  int? city;

  ResponseAdminDashboard(){}

  ResponseAdminDashboard.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    student = json['student'];
    provider = json['provider'];
    product = json['product'];
    productCategory = json['product_category'];
    galleryImage = json['gallery_image'];
    galleryVideo = json['gallery_video'];
    chatMessage = json['chat_message'];
    order = json['order'];
    subscribers = json['subscribers'];
    city = json['city'];
  }

}
