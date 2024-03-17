


import 'package:umq/modules/product/data/model/MProduct.dart';

class ResponseSearchProduct {
  List<MProduct> data;

  ResponseSearchProduct(
      this.data,
      );

  ResponseSearchProduct.fromJson(Map<String, dynamic> json)
      :data = json['data'].map<MProduct>((value) => MProduct().fromJson(value)).toList();


}


