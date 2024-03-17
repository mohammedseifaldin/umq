class ResponseRateProvider {
  String? status;
  int? code;
  String? message;
  DataRateProvider? data;

  ResponseRateProvider({this.status, this.code, this.message, this.data});

  ResponseRateProvider.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    message = json['message'];
    data = json['data'] != null ? new DataRateProvider.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }

  @override
  String toString() {
    return 'ResponseRateProvider{status: $status, code: $code, message: $message, data: $data}';
  }
}

class DataRateProvider {
  int? id;
  String? value;
  String? providerId;
  String? userId;
  String? createdAt;

  DataRateProvider({this.id, this.value, this.providerId, this.userId, this.createdAt});

  DataRateProvider.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    value = json['value'];
    providerId = json['provider_id'];
    userId = json['user_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['value'] = this.value;
    data['provider_id'] = this.providerId;
    data['user_id'] = this.userId;
    data['created_at'] = this.createdAt;
    return data;
  }

  @override
  String toString() {
    return 'DataRateProvider{id: $id, value: $value, providerId: $providerId, userId: $userId, createdAt: $createdAt}';
  }
}
