import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
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
  bool  allowedChat = true; //default is true

  RequestCreateSubscribePackage(
      {this.nameEn,
        this.nameAr,
        this.descriptionEn,
        this.descriptionAr,
        this.price,
        this.period,
        this.allowedProductNumbers,
        });




  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data["id"] = this.editObjectId;
    data['name_en'] = this.nameEn;
    data['name_ar'] = this.nameAr;
    data['description_en'] = this.descriptionEn;
    data['description_ar'] = this.descriptionAr;
    data['price'] = this.price;
    data['period'] = this.period;
    data['allowed_product_numers'] = this.allowedProductNumbers;
    data['allowed_chat'] = ToolsAPI.booleanToZeroAndOne( allowedChat??false);
    return data;
  }
}
