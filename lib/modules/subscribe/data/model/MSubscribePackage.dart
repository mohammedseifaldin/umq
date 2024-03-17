
import 'package:fastor_app_ui_widget/resource/toolsFastor/lang/LangFastor.dart';
import 'package:flutter/src/widgets/framework.dart';

class MSubscribePackage {

  int? id;
  String? nameEn;
  String? nameAr;
  String? descriptionEn;
  String? descriptionAr;
  int? price;
  int? period;
  int? allowedProductNumers;
  int? allowedChat;
  int? hidden;
  int? created;
  int? updated;

  MSubscribePackage(
      {this.id,
        this.nameEn,
        this.nameAr,
        this.descriptionEn,
        this.descriptionAr,
        this.price,
        this.period,
        this.allowedProductNumers,
        this.allowedChat,
        this.hidden,
        this.created,
        this.updated});

  MSubscribePackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameAr = json['name_ar'];
    descriptionEn = json['description_en'];
    descriptionAr = json['description_ar'];
    price = json['price'];
    period = json['period'];
    allowedProductNumers = json['allowed_product_numers'];
    allowedChat = json['allowed_chat'];
    hidden = json['hidden'];
    created = json['created'];
    updated = json['updated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['period'] = this.period;
    data['allowed_product_numers'] = this.allowedProductNumers;
    data['allowed_chat'] = this.allowedChat;
    data['hidden'] = this.hidden;
    data['created'] = this.created;
    data['updated'] = this.updated;
    return data;
  }


  static String getNameByLang(BuildContext buildContext, MSubscribePackage m) {
    if( LangFastor.isArabic ) {
      return m.nameAr??"";
    } else {
      return m.nameEn??"";
    }
  }

  static String? getNameEnglishPlusArabic(MSubscribePackage m) {
    return m.nameEn.toString()  + " " + m.nameAr.toString();
  }


}
