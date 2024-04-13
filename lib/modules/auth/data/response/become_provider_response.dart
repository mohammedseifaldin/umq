/**
    {
    "status": "success",
    "code": 1,
    "result_update_roleType": true,
    "data": {
    "user_id": "65",
    "whats": "010",
    "city_id": "1",
    "org_id": "1",
    "id": 45
    }
    }
 */
class BecomeProviderResponse {
  bool status;
  String message;
  // User? data;

  BecomeProviderResponse(
      this.status,
      this.message,
      // this.data,
      );

  BecomeProviderResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"]=='success',
        message = json["message"]??"";
        // data = json["user_details"]!=null?User.fromJson(json["user_details"]):null;

  Map<String, dynamic> toJson() => {
        'success': status,
        'message': message,
      };
}
