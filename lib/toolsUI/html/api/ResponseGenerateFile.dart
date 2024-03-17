class ResponseGenerateFile {
  String? status;
  int? code;
  bool? result;
  String? message;
  String? type;
  String? finalName;
  String? fullPath;

  ResponseGenerateFile(
      {this.status,
        this.code,
        this.result,
        this.message,
        this.type,
        this.finalName,
        this.fullPath});

  ResponseGenerateFile.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    result = json['result'];
    message = json['message'];
    type = json['type'];
    finalName = json['finalName'];
    fullPath = json['fullPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['result'] = this.result;
    data['message'] = this.message;
    data['type'] = this.type;
    data['finalName'] = this.finalName;
    data['fullPath'] = this.fullPath;
    return data;
  }
}
