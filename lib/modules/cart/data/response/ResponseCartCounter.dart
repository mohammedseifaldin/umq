class ResponseCartCounter {
  String? status;
  int? code;
  int? newCounter;
  DataSingleCart? data;

  ResponseCartCounter({this.status, this.code, this.newCounter, this.data});

  ResponseCartCounter.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    newCounter = json['new_counter'];
    data = json['data'] != null ? new DataSingleCart.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['code'] = this.code;
    data['new_counter'] = this.newCounter;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class DataSingleCart {
  int? id;
  int? userId;
  int? productId;
  int? counter;
  int? updatedAt;

  DataSingleCart({this.id, this.userId, this.productId, this.counter, this.updatedAt});

  DataSingleCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    counter = json['counter'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['product_id'] = this.productId;
    data['counter'] = this.counter;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
