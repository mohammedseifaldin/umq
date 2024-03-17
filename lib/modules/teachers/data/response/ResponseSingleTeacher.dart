import 'package:fastor_app_ui_widget/fastor_app_ui_widget.dart';
import 'package:umq/modules/place/data/model/MCity.dart';
import 'package:umq/modules/teachers/data/model/MImageGallery.dart';
import 'package:umq/modules/profile/data/model/MOrganization.dart';
import 'package:umq/modules/product/data/model/MProduct.dart';
import 'package:umq/modules/teachers/data/model/MTeacher.dart';
import 'package:umq/modules/teachers/data/model/MVideoGallery.dart';

/**
 show callery
 */
class ResponseSingleProvider {
  String? status;
  int? code;
  DataSingleProvider? data;

  ResponseSingleProvider  fromJson(Map<String, dynamic> json) {
    status = json['status'];
    code = json['code'];
    data = json['data'] != null ? new DataSingleProvider.fromJson(json['data']) : null;
    return this;
  }

  @override
  String toString() {
    return 'ResponseSingleProvider{status: $status, code: $code, data: $data}';
  }
}

class DataSingleProvider {
  MProvider? providerContent;
  List<MImageGallery>? imageGallery = [];
  List<MVideoGallery>? videoGallery = [];
  List<MProduct>? productProvider = [];


  DataSingleProvider.fromJson(Map<String, dynamic> json) {
    providerContent = json['provider_content'] != null
        ? new MProvider().fromJson(json['provider_content'])
        : null;


    if (json['image_gallery'] != null) {
      imageGallery = <MImageGallery>[];
      json['image_gallery'].forEach((v) {
        imageGallery!.add(new MImageGallery.fromJson(v));
      });
    }
   // Log.i( "DataSingleProvider - fromJson() - imageGallery: " + imageGallery.toString() );
    if (json['video_gallery'] != null) {
      videoGallery = <MVideoGallery>[];
      json['video_gallery'].forEach((v) {
        videoGallery!.add(new MVideoGallery.fromJson(v));
      });
    }
    if (json['product_provider'] != null) {
      productProvider = <MProduct>[];
      json['product_provider'].forEach((v) {
        productProvider!.add(new MProduct().fromJson(v));
      });
    }
  }

  @override
  String toString() {
    return 'DataSingleProvider{providerContent: $providerContent, imageGallery: $imageGallery, videoGallery: $videoGallery, productProvider: $productProvider}';
  }
}




