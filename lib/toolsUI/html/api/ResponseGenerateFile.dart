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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['code'] = code;
    data['result'] = result;
    data['message'] = message;
    data['type'] = type;
    data['finalName'] = finalName;
    data['fullPath'] = fullPath;
    return data;
  }
}
