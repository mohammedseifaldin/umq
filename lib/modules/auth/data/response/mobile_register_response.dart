class MobileRegisterResponse {
  bool status;
  String message;
  // User? data;

  MobileRegisterResponse(
    this.status,
    this.message,
    // this.data,
  );

  MobileRegisterResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"] == 'success',
        message = json["message"];
  // data = json["user_details"]!=null?User.fromJson(json["user_details"]):null;

  Map<String, dynamic> toJson() => {
        'success': status,
        'message': message,
      };
}
