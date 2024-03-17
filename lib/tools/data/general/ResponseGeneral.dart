class ResponseGeneral {
  String? status;
  int? code;


  ResponseGeneral fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    return data;
  }

  @override
  String toString() {
    return 'ResponseGeneral{status: $status, code: $code}';
  }
}
