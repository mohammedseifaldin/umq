import 'package:umq/tools/network/ToolsAPI.dart';

class RequestCreateSubscribePackage {
  int? editObjectId;

  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  int? price;
  int? period;
  int? allowedProductNumbers;
  bool allowedChat = true; //default is true

  RequestCreateSubscribePackage({
    this.nameEn,
    this.nameAr,
    this.descriptionEn,
    this.descriptionAr,
    this.price,
    this.period,
    this.allowedProductNumbers,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = editObjectId;
    data['name_en'] = nameEn;
    data['name_ar'] = nameAr;
    data['description_en'] = descriptionEn;
    data['description_ar'] = descriptionAr;
    data['price'] = price;
    data['period'] = period;
    data['allowed_product_numers'] = allowedProductNumbers;
    data['allowed_chat'] = ToolsAPI.booleanToZeroAndOne(allowedChat ?? false);
    return data;
  }
}
