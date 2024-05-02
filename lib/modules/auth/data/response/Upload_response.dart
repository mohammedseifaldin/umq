

class UploadResponse {
  bool status;
  String message;
  Data? data;

  UploadResponse(
      this.status,
      this.message,
      this.data,
      );

  UploadResponse.fromJson(Map<String, dynamic> json)
      : status = json["status"]=='success',
        message = json["message"],
        data = Data.fromJson(json["data"]);

  Map<String, dynamic> toJson() => {
        'success': status,
        'message': message,
      };
}
class Data {
  String path;

  Data(
      this.path,
      );

  Data.fromJson(Map<String, dynamic> json)
      :path = json["path"];


}
