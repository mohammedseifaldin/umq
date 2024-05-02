

class RegisterResponse {
  bool status;
  String message;

  RegisterResponse(
      this.status,
      this.message,
      );

  RegisterResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"]=='success',
        message = json["message"]??"";

  Map<String, dynamic> toJson() => {
        'success': status,
        'message': message,
      };
}
