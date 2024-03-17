class ResponseUploadFileLaravel {
  String? status;
  int? code;
  bool? updatePhoto;
  String? message;
  DataUploadFile? data;

  ResponseUploadFileLaravel(
      {this.status, this.code, this.updatePhoto, this.message, this.data});

  ResponseUploadFileLaravel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    updatePhoto = json['updatePhoto'];
    message = json['message'];
    data = json['data'] != null ? new DataUploadFile.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['updatePhoto'] = this.updatePhoto;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataUploadFile {
  String? flieNameOrginal;
  int? size;
  String? exe;
  String? path;

  DataUploadFile({this.flieNameOrginal, this.size, this.exe, this.path});

  DataUploadFile.fromJson(Map<String, dynamic> json) {
    flieNameOrginal = json['flieNameOrginal'];
    size = json['size'];
    exe = json['exe'];
    path = json['path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['flieNameOrginal'] = this.flieNameOrginal;
    data['size'] = this.size;
    data['exe'] = this.exe;
    data['path'] = this.path;
    return data;
  }
}
